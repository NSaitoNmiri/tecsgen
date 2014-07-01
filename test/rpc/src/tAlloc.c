/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * require port : signature: sSysLog context: task
 *   ER             write( uint_t prio, const SYSLOG* p_syslog );
 *   ER_UINT        read( SYSLOG* p_syslog );
 *   ER             mask( uint_t logmask, uint_t lowmask );
 *   ER             refer( T_SYSLOG_RLOG* pk_rlog );
 *
 * #[</PREAMBLE>]# */

#include <stdlib.h>
#include "tAlloc_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eAlloc
 * entry port: eAlloc
 * signature:  sAlloc
 * context:    task
 * #[</ENTRY_PORT>]# */

char alloc_mem[1024];

/* #[<ENTRY_FUNC>]# eAlloc_alloc
 * name:         eAlloc_alloc
 * global_name:  tAlloc_eAlloc_alloc
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eAlloc_alloc(CELLIDX idx, int32_t size, void **p)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */

	syslog(LOG_INFO, "allocated %d", size );
	/* Ķ�°׼���!!! */
	*p = (void *)alloc_mem;
	return E_OK;
}

/* #[<ENTRY_FUNC>]# eAlloc_dealloc
 * name:         eAlloc_dealloc
 * global_name:  tAlloc_eAlloc_dealloc
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eAlloc_dealloc(CELLIDX idx, const void* ptr)
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
	/* Ķ�°׼���!!!: ���⤷�ޤ��� */

	syslog(LOG_INFO, "free" );
	return(ercd);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
