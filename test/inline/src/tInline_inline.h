
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * #[</PREAMBLE>]# */

#include "tInline_tecsgen.h"

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eInline1
 * entry port: eInline1
 * signature:  sInline1
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eInline1_inline1
 * name:         eInline1_inline1
 * global_name:  tInline_eInline1_inline1
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline void
eInline1_inline1(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	cNonInline_nonInline();
}

/* #[<ENTRY_PORT>]# eInline2
 * entry port: eInline2
 * signature:  sInline2
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eInline2_inline2
 * name:         eInline2_inline2
 * global_name:  tInline_eInline2_inline2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline void
eInline2_inline2(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	cNonInline_nonInline();
}

