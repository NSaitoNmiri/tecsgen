/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCt2_template.c => src/tCt2.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * allocator port for call port: eEnt2 func: func param: a
 *   ER             eEnt2_func_a_alloc( int32_t sz, void** p );
 *   ER             eEnt2_func_a_dealloc( const void* p );
 * allocator port for call port: eEnt2 func: func2 param: buf
 *   ER             eEnt2_func2_buf_alloc( int32_t sz, void** p );
 *   ER             eEnt2_func2_buf_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

#include "tCt2_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt2
 * entry port: eEnt2
 * signature:  sSig
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt2_func
 * name:         eEnt2_func
 * global_name:  tCt2_eEnt2_func
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eEnt2_func(CELLIDX idx, int32_t* a)
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

/* #[<ENTRY_FUNC>]# eEnt2_func2
 * name:         eEnt2_func2
 * global_name:  tCt2_eEnt2_func2
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eEnt2_func2(CELLIDX idx, int8_t* buf, int32_t sz)
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

