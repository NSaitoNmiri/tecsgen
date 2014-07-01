/*
 *  TOPPERS/ASP Kernel
 *      Toyohashi Open Platform for Embedded Real-Time Systems/
 *      Advanced Standard Profile Kernel
 * 
 *  Copyright (C) 2008-2009 by Embedded and Real-Time Systems Laboratory
 *              Graduate School of Information Science, Nagoya Univ., JAPAN
 * 
 *  �嵭����Ԥϡ��ʲ���(1)��(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
 *  �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
 *  �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *  (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *      ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *      ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *  (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *      �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *      ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *  (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *      �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *      �ȡ�
 *    (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *        �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *    (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ������Ȥ�
 *        ��𤹤뤳�ȡ�
 *  (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *      ������⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ����դ��뤳�ȡ�
 *      �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
 *      ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ�
 *      ���դ��뤳�ȡ�
 * 
 *  �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *  ���TOPPERS�ץ������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
 *  ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
 *  �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
 *  ����Ǥ�����ʤ���
 * 
 *  @(#) $Id: tSemaphore_inline.h 308 2009-05-09 12:33:04Z ertl-takuya $
 */

/*
 * °�����������ޥ��� #_CAAM_#
 * id               ID               ATTR_id         
 */

/*
 * #include "tSemaphore_tecsgen.h"
 */
#include "errno.h"
#include "tecs_pthread_adaptor.h"

Inline ER Semaphore_errno_conv( int err_no )
{
	ER  err;

	switch(err_no){
	case 0:
		err = E_OK;
		break;
	case EINVAL:
		err = E_ID;
		break;
	case EBUSY:
		err = E_TMOUT;
		break;
	case EDEADLK:
		err = E_RLWAI;
		break;
//	case EPERM:
//		err = E_;  // ¾�Υ���åɤ��������褦�Ȥ�����礬���ꤵ��Ƥ��ʤ��ʵ�����ʤ�����
//		break;
	default:
		err = E_CTX;  // �褯�狼��ʤ���Τϡ��Ȥꤢ��������ƥ����ȥ��顼
	}
	return err;		
}

Inline void Semapore_once(void)
{
}


/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eSemaphore
 * entry port: eSemaphore
 * signature:  sSemaphore
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eSemaphore_signal
 * name:         eSemaphore_signal
 * global_name:  tSemaphore_eSemaphore_signal
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_signal(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(sig_sem(ATTR_id));
	return(Semaphore_errno_conv(pthread_mutex_unlock(&VAR_mutex)));
}

/* #[<ENTRY_FUNC>]# eSemaphore_wait
 * name:         eSemaphore_wait
 * global_name:  tSemaphore_eSemaphore_wait
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_wait(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(wai_sem(ATTR_id));
	return(Semaphore_errno_conv(pthread_mutex_lock(&VAR_mutex)));
}

/* #[<ENTRY_FUNC>]# eSemaphore_waitPolling
 * name:         eSemaphore_waitPolling
 * global_name:  tSemaphore_eSemaphore_waitPolling
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_waitPolling(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	errno=pthread_mutex_trylock(&VAR_mutex);
	return(Semaphore_errno_conv(errno));
}

/* #[<ENTRY_FUNC>]# eSemaphore_waitTimeout
 * name:         eSemaphore_waitTimeout
 * global_name:  tSemaphore_eSemaphore_waitTimeout
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_waitTimeout(CELLIDX idx, TMO timeout)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	int     errno;

//	return(twai_sem(ATTR_id, timeout));
	while((errno=pthread_mutex_trylock(&VAR_mutex))==EBUSY)
		usleep(1000);
	return(Semaphore_errno_conv(errno));
}

/* #[<ENTRY_FUNC>]# eSemaphore_initialize
 * name:         eSemaphore_initialize
 * global_name:  tSemaphore_eSemaphore_initialize
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_initialize(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	return(ini_sem(ATTR_id));
}

/* #[<ENTRY_FUNC>]# eSemaphore_refer
 * name:         eSemaphore_refer
 * global_name:  tSemaphore_eSemaphore_refer
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eSemaphore_refer(CELLIDX idx, T_RSEM* pk_semaphore_status)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	return(ref_sem(ATTR_id, pk_semaphore_status));
}

/* #[<ENTRY_PORT>]# eiSemaphore
 * entry port: eiSemaphore
 * signature:  siSemaphore
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eiSemaphore_signal
 * name:         eiSemaphore_signal
 * global_name:  tSemaphore_eiSemaphore_signal
 * oneway:       
 * #[/ENTRY_FUNC>]# */
Inline ER
eiSemaphore_signal(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	return(isig_sem(ATTR_id));
}
