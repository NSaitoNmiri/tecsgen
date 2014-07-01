/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tNamedRequire_template.c => src/tNamedRequire.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSyscall context: task
 *   ER             cCall_func( );
 * require port : signature: sSyscall context: task
 *   ER             cReqCall_func( );
 * require port : signature: sSyscall context: task
 *   ER             func( );
 *
 * #[</PREAMBLE>]# */

#include "tNamedRequire_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eSc
 * entry port: eSc
 * signature:  sSyscall
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eSc_func
 * name:         eSc_func
 * global_name:  tNamedRequire_eSc_func
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eSc_func(CELLIDX idx)
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


	puts( "tNamedRequire: func: called" );
	puts( "tNamedRequire: func: calling required port: func" );
	func();
	puts( "tNamedRequire: func: calling call port: cCall_func" );
	cCall_func();
	puts( "tNamedRequire: func: calling required port: cReqCall_func" );
	cReqCall_func();
	return(ercd);
}

