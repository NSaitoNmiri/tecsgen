/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tRPCAdaptor_template.c => src/tRPCAdaptor.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * jbuf             jmp_buf          VAR_jbuf        
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sTaskBody context: task
 *   void           cCall_main( );
 * call port : cOpener  signature: sSocketClientOpener context: task
 *   ER             cOpener_open( const char_t* serverAddr, uint16_t portNo, TMO tmo );
 *   ER             cOpener_simpleOpen( TMO tmo );
 *   ER             cOpener_close( TMO tmo );
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "tRPCAdaptor_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

#define  LONGJMP_SETJMP		(0)
#define  LONGJMP_OPEN		(1)
#define  LONGJMP_HANDLER	(2)

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eMain
 * entry port: eMain
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eMain_main
 * name:         eMain_main
 * global_name:  tRPCAdaptor_eMain_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eMain_main(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	int     ret;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	/* set jbuf or return by longjmp */
	if( (ret=setjmp( VAR_jbuf )) != LONGJMP_SETJMP ){
		// �㳰������ʤ���
		if( ret == LONGJMP_HANDLER ){
			// ɬ�פʤ顢�����Ǹ�����򤹤�

			// �����ͥ�ϳ����Ƥ����ΤȤ��ơ��Ĥ���
			cOpener_close( TMO_FEVR );
		}
		syslog( LOG_INFO, "tRPCAdaptor: rerun" );
		sleep( 3 );    // 3�ä��Ȥ� retry
	}


	syslog( LOG_INFO, "tRPCAdaptor: opening Channel" );
	if( cOpener_simpleOpen( TMO_FEVR ) != E_OK ){
	// if( cOpener_open("127.0.0.1", 8931, TMO_FEVR ) != E_OK ){
	// if( cOpener_open("192.168.99.2", 8931, TMO_FEVR ) != E_OK ){
		syslog( LOG_INFO, "tRPCAdaptor: fail to open" );
		// open �μ��Ԥ����ʤ� longjmp �Ǥʤ��Ƥ����뤬��handler ��Ʊ���˰���
		longjmp( VAR_jbuf, LONGJMP_OPEN );
	}

	syslog( LOG_INFO, "tRPCAdaptor: calling Main" );
	cCall_main();

	syslog(LOG_INFO, "tRPCAdaptor:  closing channel");
	cOpener_close( TMO_FEVR );
}

/* #[<ENTRY_PORT>]# eErrorHandler
 * entry port: eErrorHandler
 * signature:  sRPCErrorHandler
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eErrorHandler_errorOccured
 * name:         eErrorHandler_errorOccured
 * global_name:  tRPCAdaptor_eErrorHandler_errorOccured
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eErrorHandler_errorOccured(CELLIDX idx, int16_t func_id, ER er, int16_t state)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	longjmp( VAR_jbuf, LONGJMP_HANDLER );
	// NOTE:
	//   never return here
	//   if resources are remained open, they must be closed or resources are leaked.

	return(ercd);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
