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
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall2  signature: sSig2
 *   ER             cCall2_func1( int32_t arg1, int32_t* res );
 * call port : cCall3  signature: sSig3
 *   ER             cCall3_func1( int32_t arg1, int32_t* res );
 *
 * #[</PREAMBLE>]# */

#include "tCtR2_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt
 * entry port: eEnt
 * signature:  sSig1
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt_func1
 * name:         eEnt_func1
 * global_name:  tCtR2_eEnt_func1
 * #[/ENTRY_FUNC>]# */
ER
eEnt_func1(CELLIDX idx, int32_t arg1, int32_t* res)
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
	puts( "tCtR2.eEnt.func1 : calling cCall2_fun1" );
	cCall2_func1( arg1, res );

	puts( "tCtR2.eEnt.func1 : calling cCall3_fun1" );
	cCall3_func1( arg1, res );
	return(ercd);
}

