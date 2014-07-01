/*
 *  TECS Generator
 *      Generator for TOPPERS Embedded Component System
 *  
 *   Copyright (C) 2008-2013 by TOPPERS Project
 *--
 *   �嵭����Ԥϡ��ʲ���(1)(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
 *   �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
 *   �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *   (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *       ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *       ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *   (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *       �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *       ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *   (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *       �ȡ�
 *     (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *         �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *     (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ������Ȥ�
 *         ��𤹤뤳�ȡ�
 *   (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *       ������⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ����դ��뤳�ȡ�
 *       �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
 *       ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ�
 *       ���դ��뤳�ȡ�
 *  
 *   �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *   ���TOPPERS�ץ������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
 *   ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
 *   �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
 *   ����Ǥ�����ʤ���
 *  
 *   $Id: tRPCSharedChannelMan.c 1925 2013-01-20 05:55:58Z okuma-top $
 */

/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cSemaphore  signature: sSemaphore context: task
 *   ER             cSemaphore_signal( );
 *   ER             cSemaphore_wait( );
 *   ER             cSemaphore_waitPolling( );
 *   ER             cSemaphore_waitTimeout( TMO timeout );
 *   ER             cSemaphore_initialize( );
 *   ER             cSemaphore_refer( T_RSEM* pk_semaphore_status );
 * call port : cClientSideTDR  signature: sTDR context: task
 *   ER             cClientSideTDR_open( const int8_t* arg, int16_t size, TMO tmo );
 *   ER             cClientSideTDR_close( );
 *   ER             cClientSideTDR_reset( );
 *   ER             cClientSideTDR_sop( int_t no );
 *   ER             cClientSideTDR_is_sop( int_t no );
 *   ER             cClientSideTDR_eop( int_t no );
 *   ER             cClientSideTDR_is_eop( int_t no );
 *   ER             cClientSideTDR_set_tmo( TMO tmo );
 *   ER             cClientSideTDR_put_int8( int8_t in );
 *   ER             cClientSideTDR_put_int16( int16_t in );
 *   ER             cClientSideTDR_put_int32( int32_t in );
 *   ER             cClientSideTDR_put_int64( int64_t in );
 *   ER             cClientSideTDR_put_int128( int128_t in );
 *   ER             cClientSideTDR_get_int8( int8_t* out );
 *   ER             cClientSideTDR_get_int16( int16_t* out );
 *   ER             cClientSideTDR_get_int32( int32_t* out );
 *   ER             cClientSideTDR_get_int64( int64_t* out );
 *   ER             cClientSideTDR_get_int128( int128_t* out );
 *   ER             cClientSideTDR_put_char( char_t in );
 *   ER             cClientSideTDR_put_short( short in );
 *   ER             cClientSideTDR_put_int( int_t in );
 *   ER             cClientSideTDR_put_long( long_t in );
 *   ER             cClientSideTDR_get_char( char_t* out );
 *   ER             cClientSideTDR_get_short( short* out );
 *   ER             cClientSideTDR_get_int( int_t* out );
 *   ER             cClientSideTDR_get_long( long_t* out );
 *   ER             cClientSideTDR_put_intptr( const void* ptr );
 *   ER             cClientSideTDR_get_intptr( void** ptr );
 *
 * #[</PREAMBLE>]# */

#include "tRPCSharedChannelMan_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif


/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eSemaphore
 * entry port: eSemaphore
 * signature:  sSemaphore
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eSemaphore_signal
 * name:         eSemaphore_signal
 * global_name:  tRPCSharedTaskMain_eSemaphore_signal
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_signal(CELLIDX idx, int_t subscript)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	cClientSideTDR_putInt16( RPC_CHANNEL_MAN_EOP_MAGIC );
	ercd = cSemaphore_signal();
	// syslog( LOG_INFO, "tRPCSharedTaskMain: cSemaphore_signal" );

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eSemaphore_wait
 * name:         eSemaphore_wait
 * global_name:  tRPCSharedTaskMain_eSemaphore_wait
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_wait(CELLIDX idx, int_t subscript)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	ercd = cSemaphore_wait();
	if( ercd == E_OK ){
		// syslog( LOG_INFO, "tRPCSharedTaskMain: cSemaphore_wait" );

		cClientSideTDR_putInt16( RPC_CHANNEL_MAN_SOP_MAGIC );
		cClientSideTDR_putInt16( subscript );
	}

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eSemaphore_waitPolling
 * name:         eSemaphore_waitPolling
 * global_name:  tRPCSharedTaskMain_eSemaphore_waitPolling
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_waitPolling(CELLIDX idx, int_t subscript)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	ercd = cSemaphore_waitPolling();
	if( ercd == E_OK ){
		cClientSideTDR_putInt16( RPC_CHANNEL_MAN_SOP_MAGIC );
		cClientSideTDR_putInt16( subscript );
	}

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eSemaphore_waitTimeout
 * name:         eSemaphore_waitTimeout
 * global_name:  tRPCSharedTaskMain_eSemaphore_waitTimeout
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_waitTimeout(CELLIDX idx, int_t subscript, TMO timeout)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	ercd = cSemaphore_waitTimeout(timeout);
	if( ercd == E_OK ){
		// syslog( LOG_INFO, "tRPCSharedTaskMain: cSemaphore_waitTimeout" );

		cClientSideTDR_putInt16( RPC_CHANNEL_MAN_SOP_MAGIC );
		cClientSideTDR_putInt16( subscript );
	}

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eSemaphore_initialize
 * name:         eSemaphore_initialize
 * global_name:  tRPCSharedTaskMain_eSemaphore_initialize
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_initialize(CELLIDX idx, int_t subscript)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eSemaphore_refer
 * name:         eSemaphore_refer
 * global_name:  tRPCSharedTaskMain_eSemaphore_refer
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eSemaphore_refer(CELLIDX idx, int_t subscript, T_RSEM* pk_semaphore_status)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	return(ercd);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
