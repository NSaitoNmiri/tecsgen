/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * TECS             struct RClass *  VAR_TECS        
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cInitialize  signature: nMruby_sInitializeTECSBridge context: task
 *   void           cInitialize_initializeBridge( subscript, const mrb_state* mrb, const struct RClass * TECS );
 *       subscript:  0...(NCP_cInitialize-1)
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "nMruby_tTECSInitializer_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eInitialize
 * entry port: eInitialize
 * signature:  nMruby_sInitializeBridge
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eInitialize_initializeBridge
 * name:         eInitialize_initializeBridge
 * global_name:  nMruby_tTECSInitializer_eInitialize_initializeBridge
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eInitialize_initializeBridge(CELLIDX idx, const mrb_state* mrb)
{
	CELLCB	*p_cellcb;
	int      i;
	struct RClass *TECS;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	VAR_TECS = mrb_define_module( (mrb_state *)mrb, "TECS" );
	// mrb: const mrb_state * => mrb_state *

	for( i = 0; i < NCP_cInitialize; i++ )
		cInitialize_initializeBridge( i, (mrb_state*)mrb, VAR_TECS );
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
