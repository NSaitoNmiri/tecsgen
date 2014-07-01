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
 *   $Id: tSocketServer.c 1925 2013-01-20 05:55:58Z okuma-top $
 */

/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * portNo           int16_t          ATTR_portNo    
 * sd               int_t            VAR_sd          
 *
 * #[</PREAMBLE>]# */

#include "tSocketServer_tecsgen.h"

#include <errno.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <unistd.h>
#include "errno2ER.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif


/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eC1
 * entry port: eC1
 * signature:  sChannel
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eC1_send
 * name:         eC1_send
 * global_name:  tSocketServer_eC1_send
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC1_send(CELLIDX idx, const int8_t* buf, int16_t size, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	int     sz;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
#ifdef DEBUG
	syslog( LOG_INFO, "tSocketServer: send" );
	{
		int i;
		for( i = 0; i < size; i++ ){
			printf( "%02X ", (unsigned char)buf[i] );
			if( i % 8 == 7 )
				putchar( '\n' );
		}
		putchar( '\n' );
	}
#endif
	while(size>0){
		if((sz=write( VAR_sd, buf, (size_t)size )) < 0 ){
			ercd = errno2ER( errno );
			break;
		}
		else{
			size -= sz;
		}
	}

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC1_flush
 * name:         eC1_flush
 * global_name:  tSocketServer_eC1_flush
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC1_flush(CELLIDX idx, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC1_receive
 * name:         eC1_receive
 * global_name:  tSocketServer_eC1_receive
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER_UINT
eC1_receive(CELLIDX idx, int8_t* buf, int16_t size, TMO tmo)
{
	ER		ercd = E_OK;
	ER_UINT sz;
	CELLCB	*p_cellcb;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	if( (sz=read( VAR_sd, buf, (size_t)size )) < 0 )
		ercd = errno2ER( errno );
	else
		ercd = sz;

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC1_end_receive
 * name:         eC1_end_receive
 * global_name:  tSocketServer_eC1_end_receive
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC1_end_receive(CELLIDX idx)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC1_reset
 * name:         eC1_reset
 * global_name:  tSocketServer_eC1_reset
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC1_reset(CELLIDX idx)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	syslog( LOG_INFO, "tSocketServer: reset" );

	return(ercd);
}

/* #[<ENTRY_PORT>]# eOpener
 * entry port: eOpener
 * signature:  sServerChannelOpener
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eOpener_open
 * name:         eOpener_open
 * global_name:  tSocketServer_eOpener_open
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eOpener_open(CELLIDX idx)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	int		ssoc, soc;
	struct sockaddr_in addr={ AF_INET };

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	syslog( LOG_INFO, "tSocketServer: open" );

	ssoc=socket(AF_INET,SOCK_STREAM,0);
	if(ssoc<0){
		ercd = errno2ER( errno );
		syslog( LOG_INFO, "tSocketServer: socket failed" );
		return ercd;
	}

	addr.sin_port = htons(ATTR_portNo);
	addr.sin_addr.s_addr = INADDR_ANY;
	if(bind(ssoc,(struct sockaddr*)&addr,sizeof(addr))<0){
		ercd = errno2ER( errno );
		syslog( LOG_INFO, "tSocketServer: bind failed" );
		return ercd;
	}

	if(listen(ssoc, 1 )<0){
		ercd = errno2ER( errno );
		syslog( LOG_INFO, "tSocketServer: listen failed" );
		return ercd;
	}

    soc=accept(ssoc, NULL, NULL);
    if(soc<0){
		ercd = errno2ER( errno );
		syslog( LOG_INFO, "tSocketServer: accept failed" );
		return ercd;
	}
	syslog( LOG_INFO, "tSocketServer: accepted" );

	close( ssoc );
	VAR_sd = soc;

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eOpener_close
 * name:         eOpener_close
 * global_name:  tSocketServer_eOpener_close
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eOpener_close(CELLIDX idx)
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
	syslog( LOG_INFO, "tSocketServer: close" );
	if( close( VAR_sd ) < 0 )
		ercd = errno2ER( errno );

	return(ercd);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
