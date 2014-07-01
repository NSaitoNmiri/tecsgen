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
 *  @(#) $Id: tFixedSizeMemoryPool_inline.h 308 2009-05-09 12:33:04Z ertl-takuya $
 */

/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * id               ID               ATTR_id         
 * mutex            pthread_mutex_t  VAR_mutex       
 * cond             pthread_cond_t   VAR_cond        
 * pattern          FLGPTN           VAR_pattern     
 *
 * #[</PREAMBLE>]# */

#include "errno.h"
#include "tEventflag_tecsgen.h"

Inline ER Eventflag_errno_conv( int err_no )
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
	case ETIMEDOUT:
		err = E_TMOUT;
		break;
//	case EPERM:
//		err = E_;  // ¾�Υ���åɤ��������褦�Ȥ�����礬���ꤵ��Ƥ��ʤ��ʵ�����ʤ�����
//		break;
	default:
		err = E_CTX;  // �褯�狼��ʤ���Τϡ��Ȥꤢ��������ƥ����ȥ��顼
	}
	return err;		
}

#ifdef Inline
#undef Inline
#endif
#define Inline

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEventflag
 * entry port: eEventflag
 * signature:  sEventflag
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEventflag_set
 * name:         eEventflag_set
 * global_name:  tEventflag_eEventflag_set
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_set(CELLIDX idx, FLGPTN set_pattern)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);

// puts("flag_set");
	if( pthread_mutex_lock( &VAR_mutex ) != 0 ){
		printf( "eEventflag_set: fail to lock mutext\n" );
	}
	VAR_pattern |= set_pattern;
	if( pthread_mutex_unlock( &VAR_mutex ) != 0 ){
		printf( "eEventflag_set: fail to unlock mutext\n" );
	}
	if( pthread_cond_signal( &VAR_cond ) != 0 ){
		printf( "eEventflag_set: fail to signal cond\n" );
	}
	return E_OK;
}

/* #[<ENTRY_FUNC>]# eEventflag_clear
 * name:         eEventflag_clear
 * global_name:  tEventflag_eEventflag_clear
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_clear(CELLIDX idx, FLGPTN clear_pattern)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);

// puts("flag_clear");
	if( pthread_mutex_lock( &VAR_mutex ) != 0 ){
		printf( "eEventflag_clear: fail to lock mutext\n" );
	}
	VAR_pattern &= clear_pattern;
	if( pthread_mutex_unlock( &VAR_mutex ) != 0 ){
		printf( "eEventflag_clear: fail to unlock mutext\n" );
	}

	if( pthread_cond_signal( &VAR_cond ) != 0 ){
		printf( "eEventflag_clear: fail to signal cond\n" );
	}
	
	return E_OK;
}

/* #[<ENTRY_FUNC>]# eEventflag_wait
 * name:         eEventflag_wait
 * global_name:  tEventflag_eEventflag_wait
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_wait(CELLIDX idx, FLGPTN wait_pattern, MODE wait_flag_mode, FLGPTN* p_flag_pattern)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	bool_t  b_condition = false;
	int		err;

	while(1){
		if( pthread_mutex_lock( &VAR_mutex ) != 0 ){
			printf( "eEventflag_wait: fail to lock mutext\n" );
		}

		if( ( wait_flag_mode == TWF_ANDW && ( wait_pattern & VAR_pattern ) == wait_pattern )
			|| ( wait_flag_mode == TWF_ORW && ( wait_pattern & VAR_pattern ) ) ){
			b_condition = true;
			err = 0;
		}

		if( b_condition == true ){
			if( (err=pthread_mutex_unlock( &VAR_mutex )) != 0 ){
				printf( "eEventflag_wait: fail to unlock mutext: errno = %d\n", err );
			}
			break;
		}

		if( pthread_cond_wait( &VAR_cond, &VAR_mutex ) != 0 ){
			printf( "eEventflag_wait: fail to wait cond\n" );
		}
		if( (pthread_mutex_unlock( &VAR_mutex )) != 0 ){
			printf( "eEventflag_waitTimeout: fail to unlock mutext\n" );
		}
	};

	return 	Eventflag_errno_conv( err );
}

/* #[<ENTRY_FUNC>]# eEventflag_waitPolling
 * name:         eEventflag_waitPolling
 * global_name:  tEventflag_eEventflag_waitPolling
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_waitPolling(CELLIDX idx, FLGPTN wait_pattern, MODE wait_flag_mode, FLGPTN* p_flag_pattern)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(pol_flg(ATTR_id, wait_pattern, wait_flag_mode, p_flag_pattern));
}

/* #[<ENTRY_FUNC>]# eEventflag_waitTimeout
 * name:         eEventflag_waitTimeout
 * global_name:  tEventflag_eEventflag_waitTimeout
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_waitTimeout(CELLIDX idx, FLGPTN wait_pattern, MODE wait_flag_mode, FLGPTN* p_flag_pattern, TMO timeout)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
	bool_t  b_condition = false;
	int     err;

// puts("flg_waitTimedout");

	while(1){
		if( (err=pthread_mutex_lock( &VAR_mutex )) != 0 ){
			printf( "eEventflag_waitTimeout: fail to lock mutext: errno = %d\n", err );
		}
		if( ( wait_flag_mode == TWF_ANDW && ( wait_pattern & VAR_pattern ) == wait_pattern )
			|| ( wait_flag_mode == TWF_ORW && ( wait_pattern & VAR_pattern ) ) ){
			b_condition = true;
			err = 0;
		}
		if( b_condition == true ){
			if( (err=pthread_mutex_unlock( &VAR_mutex )) != 0 ){
				printf( "eEventflag_waitTimeout: fail to unlock mutext: errno = %d\n", err );
			}
			break;
		}
		if( timeout == TMO_POL ){
			if( (err=pthread_mutex_unlock( &VAR_mutex )) != 0 ){
				printf( "eEventflag_waitTimeout: fail to unlock mutext: errno = %d\n", err );
			}
			err = ETIMEDOUT;
			break;
		}

//		puts( "cond wait" );
		if( (err=pthread_cond_wait( &VAR_cond, &VAR_mutex )) != 0 ){
			printf( "eEventflag_waitTimeout: fail to wait cond: errno = %d\n", err );
		}
		if( (err=pthread_mutex_unlock( &VAR_mutex )) != 0 ){
			printf( "eEventflag_waitTimeout: fail to unlock mutext: errno = %d\n", err );
		}

	}

	return 	Eventflag_errno_conv( err );
}

/* #[<ENTRY_FUNC>]# eEventflag_initialize
 * name:         eEventflag_initialize
 * global_name:  tEventflag_eEventflag_initialize
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_initialize(CELLIDX idx)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(ini_flg(ATTR_id));
}

/* #[<ENTRY_FUNC>]# eEventflag_refer
 * name:         eEventflag_refer
 * global_name:  tEventflag_eEventflag_refer
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eEventflag_refer(CELLIDX idx, T_RFLG* pk_eventflag_status)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(ref_flg(ATTR_id, pk_eventflag_status));
}

/* #[<ENTRY_PORT>]# eiEventflag
 * entry port: eiEventflag
 * signature:  siEventflag
 * context:    non-task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eiEventflag_set
 * name:         eiEventflag_set
 * global_name:  tEventflag_eiEventflag_set
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eiEventflag_set(CELLIDX idx, FLGPTN set_pattern)
{
	CELLCB	*p_cellcb = GET_CELLCB(idx);
//	return(iset_flg(ATTR_id, set_pattern));
}

