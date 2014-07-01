/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCTBool_T_template.c => src/tCTBool_T.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * boo              bool_t           ATTR_boo        
 * boo2             bool_t           ATTR_boo2       
 * boo3             bool_t           ATTR_boo3       
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "tCTBool_T_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eBooo
 * entry port: eBooo
 * signature:  sSigBool_T
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eBooo_func
 * name:         eBooo_func
 * global_name:  tCTBool_T_eBooo_func
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
bool_t
eBooo_func(CELLIDX idx, bool_t boo, bool_t* boo2)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	*boo2 = false;
	printf( "func: boo=%d *boo2=%d\n", boo, *boo2 );
}

/* #[<ENTRY_FUNC>]# eBooo_func2
 * name:         eBooo_func2
 * global_name:  tCTBool_T_eBooo_func2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
bool_t*
eBooo_func2(CELLIDX idx, const bool_t* boo, int sz)
{
	CELLCB	*p_cellcb;
	int_t	i;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
