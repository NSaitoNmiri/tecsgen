/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tTaskMain_template.c => src/tTaskMain.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cQueue  signature: sDataqueue context: task
 *   ER             cQueue_send( intptr_t data );
 *   ER             cQueue_sendPolling( intptr_t data );
 *   ER             cQueue_sendTimeout( intptr_t data, TMO timeout );
 *   ER             cQueue_sendForce( intptr_t data );
 *   ER             cQueue_receive( intptr_t* p_data );
 *   ER             cQueue_receivePolling( intptr_t* p_data );
 *   ER             cQueue_receiveTimeout( intptr_t* p_data, TMO timeout );
 *   ER             cQueue_initialize( );
 *   ER             cQueue_refer( T_RDTQ* pk_dataqueue_status );
 *
 * #[</PREAMBLE>]# */

#include "tTaskMain_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eTaskBody
 * entry port: eTaskBody
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eTaskBody_main
 * name:         eTaskBody_main
 * global_name:  tTaskMain_eTaskBody_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eTaskBody_main(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	char   msg[] = "hello\n";
	int    data, i;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	printf( "Dataqueue test 0\n" );
	cQueue_initialize();

	printf( "Dataqueue test 1\n" );
	for( i = 0; i < sizeof msg; i++ )
		cQueue_send( msg[i] );

	printf( "Dataqueue test 2\n" );
	for( i = 0; i < sizeof msg; i++ ){
		cQueue_receive( &data );
		putchar( data );
	}
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
