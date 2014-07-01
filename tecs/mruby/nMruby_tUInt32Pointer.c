/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "nMruby_tUInt32Pointer_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

GET_SET_INT( UInt32, uint32_t )
POINTER_CLASS( UInt32, uint32_t )
CHECK_AND_GET_POINTER( UInt32, uint32_t )

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eInitialize
 * entry port: eInitialize
 * signature:  nMruby_sInitializeTECSBridge
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eInitialize_initializeBridge
 * name:         eInitialize_initializeBridge
 * global_name:  nMruby_tUInt32Pointer_eInitialize_initializeBridge
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eInitialize_initializeBridge(mrb_state* mrb, struct RClass * TECS)
{
	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	(void)tecs_init_UInt32Pointer( mrb, TECS );
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
