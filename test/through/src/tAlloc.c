
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * n_alloc          int32_t          VAR_n_alloc     
 * n_dealloc        int32_t          VAR_n_dealloc   
 *
 * #[</PREAMBLE>]# */

#include "tAlloc_tecsgen.h"
#include "stddef.h"

#ifndef E_OK
#define	E_OK		0		/* ���ｪλ */
#define	E_ID		(-18)		/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eA
 * entry port: eA
 * signature:  sAlloc
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eA_alloc
 * name:         eA_alloc
 * global_name:  tAlloc_eA_alloc
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eA_alloc(int32_t sz, void **ptr)
{
    *ptr = malloc( sz );

    /* malloc �� NULL �ʤ� */
	if( *ptr == 0 )  return E_NOMEM;
	else             return E_OK;
}

/* #[<ENTRY_FUNC>]# eA_dealloc
 * name:         eA_dealloc
 * global_name:  tAlloc_eA_dealloc
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eA_dealloc(const void* ptr)
{
	free( ptr );
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
