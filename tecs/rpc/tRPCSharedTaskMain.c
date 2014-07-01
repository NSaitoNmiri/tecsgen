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
 *   $Id: tRPCSharedTaskMain.c 1925 2013-01-20 05:55:58Z okuma-top $
 */

/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * channelNo        int16_t          VAR_channelNo   
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cUnmarshalAndCallFunction  signature: sTaskBody context: task
 *   void           cUnmarshalAndCallFunction_main( subscript );
 * call port : cServerSideTDR  signature: sTDR context: task
 *   ER             cServerSideTDR_reset( );
 *   ER             cServerSideTDR_sendSOP( bool_t b_client );
 *   ER             cServerSideTDR_receiveSOP( bool_t b_client );
 *   ER             cServerSideTDR_sendEOP( bool_t b_continue );
 *   ER             cServerSideTDR_receiveEOP( bool_t b_continue );
 *   ER             cServerSideTDR_putInt8( int8_t in );
 *   ER             cServerSideTDR_putInt16( int16_t in );
 *   ER             cServerSideTDR_putInt32( int32_t in );
 *   ER             cServerSideTDR_putInt64( int64_t in );
 *   ER             cServerSideTDR_putInt128( int128_t in );
 *   ER             cServerSideTDR_getInt8( int8_t* out );
 *   ER             cServerSideTDR_getInt16( int16_t* out );
 *   ER             cServerSideTDR_getInt32( int32_t* out );
 *   ER             cServerSideTDR_getInt64( int64_t* out );
 *   ER             cServerSideTDR_getInt128( int128_t* out );
 *   ER             cServerSideTDR_putFloat32( float32_t in );
 *   ER             cServerSideTDR_putDouble64( double64_t in );
 *   ER             cServerSideTDR_getFloat32( float32_t* out );
 *   ER             cServerSideTDR_getDouble64( double64_t* out );
 *   ER             cServerSideTDR_putChar( char_t in );
 *   ER             cServerSideTDR_putShort( short in );
 *   ER             cServerSideTDR_putInt( int_t in );
 *   ER             cServerSideTDR_putLong( long_t in );
 *   ER             cServerSideTDR_getChar( char_t* out );
 *   ER             cServerSideTDR_getShort( short* out );
 *   ER             cServerSideTDR_getInt( int_t* out );
 *   ER             cServerSideTDR_getLong( long_t* out );
 *   ER             cServerSideTDR_putIntptr( const intptr_t ptr );
 *   ER             cServerSideTDR_getIntptr( intptr_t* ptr );
 * require port : signature: sSysLog context: task
 *   ER             write( uint_t prio, const SYSLOG* p_syslog );
 *   ER_UINT        read( SYSLOG* p_syslog );
 *   ER             mask( uint_t logmask, uint_t lowmask );
 *   ER             refer( T_SYSLOG_RLOG* pk_rlog );
 *
 * #[</PREAMBLE>]# */

#include "tRPCSharedTaskMain_tecsgen.h"
#include "t_syslog.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eMain
 * entry port: eMain
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eMain_main
 * name:         eMain_main
 * global_name:  tRPCSharedTaskMain_eMain_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eMain_main(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	syslog( LOG_INFO, "Shared RPC server task started." );
	while(1){
		int16_t magic;
		ER      er;

		er = cServerSideTDR_getInt16( &magic );
		if( er != E_OK ){
			syslog( LOG_INFO, "err: getInt16 for SOP_MAGIC(%X)", er );
			continue;
		}
		if( magic != RPC_CHANNEL_MAN_SOP_MAGIC ){
			syslog( LOG_INFO, "illegal SOP magic(%X): retrying", (uint16_t)magic );
			continue;
		}
		er = cServerSideTDR_getInt16( &VAR_channelNo );
		if( er != E_OK ){
			syslog( LOG_INFO, "err: getInt16 for channelNo(%X)", er );
			continue;
		}
		if( VAR_channelNo < 0 || VAR_channelNo >= N_CP_cUnmarshalAndCallFunction(p_cellcb) ){
			syslog( LOG_INFO, "illegal channel number(%X): retrying", (uint16_t)VAR_channelNo );
			continue;
		}
		syslog( LOG_INFO, "Shared Channel: servicing channel No. %d", VAR_channelNo );
		
		cUnmarshalAndCallFunction_main( VAR_channelNo );

		er = cServerSideTDR_getInt16( &magic );
		if( er != E_OK ){
			syslog( LOG_INFO, "err: getInt16 for EOP_MAGIC(%X)", er );
			continue;
		}
		if( magic != RPC_CHANNEL_MAN_EOP_MAGIC ){
			syslog( LOG_INFO, "illegal EOP magic(%X): retrying", (uint16_t)magic );
			continue;
		}
	}
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
