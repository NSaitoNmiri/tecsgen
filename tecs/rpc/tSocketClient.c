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
 *   $Id: tSocketClient.c 1925 2013-01-20 05:55:58Z okuma-top $
 */

/* #[<PREAMBLE>]#
 * Don't edit the comments between #[<...>]# and #[</...>]#
 * These comment are used by tecsmerege when merging.
 *
 * attr access macro #_CAAM_#
 * portNo           int16_t          ATTR_portNo    
 * serverAddr       char_t*          ATTR_serverAddr
 * sd               int_t            VAR_sd          
 *
 * #[</PREAMBLE>]# */

#include "tSocketClient_tecsgen.h"

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
/* #[<ENTRY_PORT>]# eC0
 * entry port: eC0
 * signature:  sChannel
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eC0_send
 * name:         eC0_send
 * global_name:  tSocketClient_eC0_send
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC0_send(CELLIDX idx, const int8_t* buf, int16_t size, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	ssize_t sz;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	// mikan BUG  buf �ΰ��֤򹹿����Ƥ��ʤ�
	while(size>0){
		if((sz=write( VAR_sd, buf, (ssize_t)size )) < 0 ){
#ifdef RPC_DEBUG
			perror( "eC0_send" );
			syslog( LOG_INFO, "eC0_send: sd %d, writing %d bytes, ercd=%d", VAR_sd, size, ercd );
#endif
			ercd = errno2ER( errno );
			break;
		}
		else{
			size -= sz;
		}
	}

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC0_flush
 * name:         eC0_flush
 * global_name:  tSocketClient_eC0_flush
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC0_flush(CELLIDX idx, TMO tmo)
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
	/* write �ϥХåե���󥰤ʤ��ʤΤ� flush ���ʤ� */

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC0_receive
 * name:         eC0_receive
 * global_name:  tSocketClient_eC0_receive
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER_UINT
eC0_receive(CELLIDX idx, int8_t* buf, int16_t size, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	ssize_t  sz;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	sz = read( VAR_sd, buf, (ssize_t)size );
	ercd = errno2ER( errno );
#ifdef DEBUG
	{
		int i;
		for( i = 0; i < sz; i++ ){
			printf( "%02X ", (unsigned char)buf[i] );
			if( i % 8 == 7 )
				putchar( '\n' );
		}
		putchar( '\n' );
	}
#endif
	/* mikan ��ȯ�������ɤ��Ȳ��� */
	if( sz >= 0 )
		ercd = sz;

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eC0_end_receive
 * name:         eC0_end_receive
 * global_name:  tSocketClient_eC0_end_receive
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC0_end_receive(CELLIDX idx)
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

/* #[<ENTRY_FUNC>]# eC0_reset
 * name:         eC0_reset
 * global_name:  tSocketClient_eC0_reset
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eC0_reset(CELLIDX idx)
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

/* #[<ENTRY_PORT>]# eOpener
 * entry port: eOpener
 * signature:  sSocketClientOpener
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eOpener_open
 * name:         eOpener_open
 * global_name:  tSocketClient_eOpener_open
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eOpener_open(CELLIDX idx, const char_t* serverAddr, uint16_t portNo, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	int		soc;
	struct sockaddr_in addr={AF_INET};

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	soc=socket(AF_INET, SOCK_STREAM, 0);
	if(soc<0){
		ercd = errno2ER( errno );
		syslog( LOG_INFO, "SocketClient: socket failed");
		return ercd;
	}

#if 0
/* �Υ�֥�å����ѹ� */
	int flag=fcntl(soc, F_GETFL, 0);
	if(flag<0) perror("fcntl(GET) error");
	if(fcntl(soc, F_SETFL, flag|O_NONBLOCK)<0) perror("fcntl(NONBLOCK) error");
#endif /* 0 */

	puts( "connecting" );
	inet_aton( serverAddr, &addr.sin_addr );
	addr.sin_port=htons(portNo);
	if(connect(soc, (struct sockaddr*)&addr, sizeof(addr))<0){
		ercd = errno2ER( errno );
		close( soc );
		printf( "connect fail errno=%d, ercd=%d\n", errno, ercd );
		syslog( LOG_INFO, "SocketClient: connect" );
		return ercd;
	}
	VAR_sd = soc;

#if 0
	if(errno!=EINPROGRESS)
		perror("connect error");
	//EINPROGRESS:���ͥ�������׵�ϻϤޤä������ޤ���λ���Ƥ��ʤ�

	fd_set rmask,wmask;FD_ZERO(&rmask);FD_SET(soc,&rmask);wmask=rmask;
	struct timeval tv={ �����ॢ���Ȼ���[��],[����] };
	int rc=select(soc+1, &rmask, &wmask, NULL, &tv);
	if(rc<0) perror("connect-select error");
	if(rc==0){ �����ॢ���Ƚ��� }
	if(rc==2){ //�ɤ߽񤭤�Ʊ���˽������
#if Solaris
		int val;
		socklen_t len=sizeof(val);
		if(getsockopt(soc,SOL_SOCKET,SO_ERROR, &val,&len)>=0) {
#elif Linux
			struct sockaddr_in name;
			socklen_t len=sizeof(name);
			if(getpeername(soc,(struct sockaddr*)&name,&len)>=0) {
#endif
				// ���˥ǡ�������Ƥ���
			}else{
				// ���ͥ��ȼ���
			}
		}
	}
//�ե饰�򸵤��᤹
	if(fcntl(soc, F_SETFL, flag)<0) perror("fcntl(END) error");
#endif /* 0 */

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eOpener_simpleOpen
 * name:         eOpener_simpleOpen
 * global_name:  tSocketClient_eOpener_simpleOpen
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eOpener_simpleOpen(CELLIDX idx, TMO tmo)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* Put statements here #_TEFB_# */
	ercd = eOpener_open(idx, ATTR_serverAddr, ATTR_portNo, tmo);

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eOpener_close
 * name:         eOpener_close
 * global_name:  tSocketClient_eOpener_close
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eOpener_close(CELLIDX idx, TMO tmo)
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
	close( VAR_sd );       /* mikan ���顼���� */

	return(ercd);
}

/* #[<POSTAMBLE>]#
 *   Put non-entry functions below.
 * #[</POSTAMBLE>]#*/
