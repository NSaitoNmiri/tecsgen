/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tMain_template.c => src/tMain.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cMain  signature: sSig context: task
 *   void           cMain_func( subscript );
 *
 * #[</PREAMBLE>]# */

#include "tMain_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

main()
{
	int32_t  i, res;
	struct tagST st;

	printf( "tMain: testing func() ***\n" );
	for( i = 0; i < N_CP_cMain; i++ )
		cMain_func( i );
	printf( "\ntMain: testing func2() ***\n" );
	for( i = 0; i < N_CP_cMain; i++ ){
		res = cMain_func2( i, 100+i );
		printf( "tMain: func2[%d] = %d\n", i, res );
	}
	printf( "\ntMain: testing func3() ***\n" );
	for( i = 0; i < N_CP_cMain; i++ ){
		st.a = 101;
		st = cMain_func3( i, st );
		printf( "tMain: func3[%d] = %d\n", i, st.a );
	}
}
