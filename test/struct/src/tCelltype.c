/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCelltype_template.c => src/tCelltype.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * allocator port for call port: eEnt func: func5 param: inp
 *   ER             eEnt_func5_inp_alloc( int32_t size, void** p );
 *   ER             eEnt_func5_inp_dealloc( const void* p );
 * allocator port for call port: eEnt func: func5 param: outp
 *   ER             eEnt_func5_outp_alloc( int32_t size, void** p );
 *   ER             eEnt_func5_outp_dealloc( const void* p );
 * allocator port for call port: eEnt func: func6 param: sendp
 *   ER             eEnt_func6_sendp_alloc( int32_t size, void** p );
 *   ER             eEnt_func6_sendp_dealloc( const void* p );
 * allocator port for call port: eEnt func: func6 param: receivep
 *   ER             eEnt_func6_receivep_alloc( int32_t size, void** p );
 *   ER             eEnt_func6_receivep_dealloc( const void* p );
 * allocator port for call port: eEnt func: func6 param: strs
 *   ER             eEnt_func6_strs_alloc( int32_t size, void** p );
 *   ER             eEnt_func6_strs_dealloc( const void* p );
 * allocator port for call port: eEnt func: func6 param: strr
 *   ER             eEnt_func6_strr_alloc( int32_t size, void** p );
 *   ER             eEnt_func6_strr_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� */
#include "tCelltype_tecsgen.h"

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

/* #[<ENTRY_FUNC>]# eEnt_func1
 * name:         eEnt_func1
 * global_name:  tCelltype_eEnt_func1
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func1(CELLIDX idx, struct tagStruct  in, const struct tagStruct * in_p, struct tagStruct * inout_p, struct tagStruct * out_p)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eEnt_func2
 * name:         eEnt_func2
 * global_name:  tCelltype_eEnt_func2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func2(CELLIDX idx, struct tagStruct  in, const struct tagStruct * in_p, struct tagStruct * inout_p, struct tagStruct * out_p, int32_t len)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eEnt_func3
 * name:         eEnt_func3
 * global_name:  tCelltype_eEnt_func3
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func3(CELLIDX idx, struct tagStruct2  in, const struct tagStruct2 * in_p, struct tagStruct2 * inout_p, struct tagStruct2 * out_p)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eEnt_func4
 * name:         eEnt_func4
 * global_name:  tCelltype_eEnt_func4
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func4(CELLIDX idx, struct tagStruct2  in, const struct tagStruct2 * in_p, struct tagStruct2 * inout_p, struct tagStruct2 * out_p, int32_t len)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eEnt_func5
 * name:         eEnt_func5
 * global_name:  tCelltype_eEnt_func5
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func5(CELLIDX idx, struct tagStruct * inp, struct tagStruct ** outp)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	EENT_FUNC5_INP_DEALLOC(inp);


}

/* #[<ENTRY_FUNC>]# eEnt_func6
 * name:         eEnt_func6
 * global_name:  tCelltype_eEnt_func6
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
struct tagStruct 
eEnt_func6(CELLIDX idx, struct tagStruct2 * sendp, struct tagStruct2 ** receivep, char_t** strs, char_t*** strr, int32_t* len)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	EENT_FUNC6_SENDP_DEALLOC(sendp, *len);
	EENT_FUNC6_STRS_DEALLOC(strs, *len);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
