/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tVMTUselessOptimizeCallee_template.c => src/tVMTUselessOptimizeCallee.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * attribute        int32_t          ATTR_attribute  
 *
 * #[</PREAMBLE>]# */

#include "tVMTUselessOptimizeCallee_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt
 * entry port: eEnt
 * signature:  sSig
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt_func
 * name:         eEnt_func
 * global_name:  tVMTUselessOptimizeCallee_eEnt_func
 * oneway:       
 * #[/ENTRY_FUNC>]# */
void
eEnt_func(CELLIDX idx, int_t subscript)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	printf( "tVMTUselessOptimizeCallee: eEnt_func: called\n" );

}

/* #[<ENTRY_FUNC>]# eEnt_func2
 * name:         eEnt_func2
 * global_name:  tSingleCellOptimizeCallee_eEnt_func2
 * oneway:       
 * #[/ENTRY_FUNC>]# */
int32_t
eEnt_func2(CELLIDX idx, int_t subscript, int32_t arg)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	printf( "tVMTUselessOptimizeCallee: eEnt_func2: called\n" );
	return 31;

}

/* #[<ENTRY_FUNC>]# eEnt_func3
 * name:         eEnt_func3
 * global_name:  tSingleCellOptimizeCallee_eEnt_func3
 * oneway:       
 * #[/ENTRY_FUNC>]# */
struct tagST 
eEnt_func3(CELLIDX idx, int_t subscript, struct tagST  a)
{
	CELLCB	*p_cellcb;
	struct tagST st;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	printf( "tVMTUselessOptimizeCallee: eEnt_func3: called\n" );
	st.a = 102;
	return st;
}


