/* #[<PREAMBLE>]#
 * #[<...>]# から #[</...>]# で囲まれたコメントは編集しないでください
 * tecsmerge によるマージに使用されます
 *
 * 属性アクセスマクロ #_CAAM_#
 * task_attribute   ATR              ATTR_task_attribute
 * exception_attribute ATR              ATTR_exception_attribute
 * priority         PRI              ATTR_priority   
 * stack_size       SIZE             ATTR_stack_size 
 * name             char_t*          ATTR_name       
 *
 * 呼び口関数 #_TCPF_#
 * call port : cBody  signature: sTaskBody context: task
 *   void           cBody_main( );
 * call port : cExceptionBody  signature: sTaskExceptionBody context: task
 *   void           cExceptionBody_main( TEXPTN pattern );
 *
 * #[</PREAMBLE>]# */

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <errno.h>
#include "tTask_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* 正常終了 */
#define	E_ID	(-18)	/* 不正ID番号 */
#endif

/* Simple error handling functions */
#define handle_error_en(en, msg) \
        do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)

/* 関数プロトタイプ宣言 */
static void	prepare_signal();
static void *sig_thread(void *arg);

#define N_PTHREAD   100
pthread_t  pthread[N_PTHREAD];
int        n_pthread = 0;

void *tTask_call_cBody_main( void *p )
{
	CELLCB *p_cellcb = (CELLCB *)p;
	fprintf( stderr, "starting task '%s'  %08X\n", ATTR_name, tTask_call_cBody_main );
	cBody_main();
	fprintf( stderr, "exiting task '%s'\n", ATTR_name );
	pthread_exit(0);

	return (void *)0;
}


int main(int arg, char **argv)
{
	int		i;
	CELLCB	*p_cellcb;
	int		result;

	/* 不要なシグナルの無視 */
	prepare_signal();

	FOREACH_CELL( i, p_cellcb )
		if( ATTR_taskAttribute & TA_ACT ){
			if( n_pthread >= N_PTHREAD ){
				fprintf( stderr, "too many threads max=%d", N_PTHREAD );
				exit( 1 );
			}
			pthread_create( &pthread[n_pthread], NULL, tTask_call_cBody_main, (void *)p_cellcb );
			n_pthread++;
		}
	END_FOREACH_CELL

	/* すべてのスレッドが終わるのを待つ */
	while( --n_pthread >= 0 ){
		pthread_join( pthread[n_pthread], (void *)&result );
//		fprintf( stderr, "thread[%d] exited with status %d\n", n_pthread, result );
	}
}
/* #[<POSTAMBLE>]#
 *   これより下に非受け口関数を書きます
 * #[</POSTAMBLE>]#*/

/*
 * 不要シグナルの無視
 *   socket への write で、相手がすでにいない場合 SIGPIPE が発生するのを無視
 */
static void
prepare_signal()
{
	int			result;
    pthread_t	thread;
    sigset_t	set;
    int 		s;

    sigemptyset(&set);
    sigaddset(&set, SIGPIPE);     /* SIGPIPE の無視 */
    s = pthread_sigmask(SIG_BLOCK, &set, NULL);
    if (s != 0)
        handle_error_en(s, "pthread_sigmask");

	/* 不要シグナル補足スレッドの生成 */
    s = pthread_create(&thread, NULL, &sig_thread, (void *) &set);
    if (s != 0)
        handle_error_en(s, "pthread_create");
}

/*
 * 不要なシグナルを補足
 */
static void *
sig_thread(void *arg)
{
    sigset_t *set = (sigset_t *) arg;
    int s, sig;

    for (;;) {
        s = sigwait(set, &sig);
        if (s != 0)
            handle_error_en(s, "sigwait");
        printf("Signal handling thread got signal %d\n", sig);
    }
}
