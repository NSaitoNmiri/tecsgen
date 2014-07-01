/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tRelay_template.c => src/tRelay.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSig context: task
 *   ER             cCall_func( int32_t* a );
 *   ER             cCall_func2( int8_t* buf, int32_t sz );
 * allocator port for call port: eEnt func: func param: a
 *   ER             eEnt_func_a_alloc( int32_t sz, void** p );
 *   ER             eEnt_func_a_dealloc( const void* p );
 * allocator port for call port: eEnt func: func2 param: buf
 *   ER             eEnt_func2_buf_alloc( int32_t sz, void** p );
 *   ER             eEnt_func2_buf_dealloc( const void* p );
 * allocator port for call port: cCall func: func param: a
 *   ER             cCall_func_a_alloc( int32_t sz, void** p );
 *   ER             cCall_func_a_dealloc( const void* p );
 * allocator port for call port: cCall func: func2 param: buf
 *   ER             cCall_func2_buf_alloc( int32_t sz, void** p );
 *   ER             cCall_func2_buf_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "tRelay_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt
 * entry port: eEnt
 * signature:  sSig
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt_func
 * name:         eEnt_func
 * global_name:  tRelay_eEnt_func
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_func(CELLIDX idx, int32_t* a)
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

/* #[<ENTRY_FUNC>]# eEnt_func2
 * name:         eEnt_func2
 * global_name:  tRelay_eEnt_func2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_func2(CELLIDX idx, int8_t* buf, int32_t sz)
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
