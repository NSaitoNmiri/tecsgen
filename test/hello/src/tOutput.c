/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/_template.c => src/.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * #[</PREAMBLE>]# */

#include "tOutput_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* <<< */
/* ���Υե������ gen/tOutput_templ.c �� src/tOutput.c �˰ܤ��ƻ��Ѥ��ޤ� */
/* <<< */

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# ePrint
 * entry port: ePrint
 * signature:  sPrint
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# ePrint_print
 * name:         ePrint_print
 * global_name:  tOutput_ePrint_print
 * #[/ENTRY_FUNC>]# */
void
ePrint_print(CELLIDX idx, const char_t* str)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	printf( str );      /* <<< �ɵ� */
}

