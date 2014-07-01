/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "nMruby_tUCharPointer_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

GET_SET_INT( UChar, uchar_t )
POINTER_CLASS( UChar, uchar_t )
#ifndef  TECS_Use_MrbString_for_CharPointer
CHECK_AND_GET_POINTER( UChar, uchar_t )
#else
CHECK_AND_GET_CHAR_POINTER( UChar, uchar_t )
CHECK_AND_GET_CHAR_POINTER_MOD( UChar, uchar_t )
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eInitialize
 * entry port: eInitialize
 * signature:  nMruby_sInitializeTECSBridge
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eInitialize_initializeBridge
 * name:         eInitialize_initializeBridge
 * global_name:  nMruby_tUCharPointer_eInitialize_initializeBridge
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eInitialize_initializeBridge(mrb_state* mrb, struct RClass * TECS)
{
	struct RClass *c;

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	c=tecs_init_UCharPointer( mrb, TECS );
	mrb_define_method(mrb, c, "to_s", CharPointer_to_s, ARGS_NONE());
	mrb_define_method(mrb, c, "from_s", CharPointer_from_s, ARGS_REQ(1));
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
