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
 * °�����������ޥ��� #_CAAM_#
 * a                int32_t       ATTR_a          
 * b                int32_t       VAR_b           
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSig2
 *   ER             cCall_func1( int32_t a );
 *   int32_t     cCall_func2( int32_t a );
 *
 * #[</PREAMBLE>]# */

#include "tCell2_active_single_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEntry
 * entry port: eEntry
 * signature:  sSig3
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEntry_func1
 * name:         eEntry_func1
 * global_name:  tCell2_active_single_eEntry_func1
 * #[/ENTRY_FUNC>]# */
ER
eEntry_func1(int32_t a)
{
}

/* #[<ENTRY_FUNC>]# eEntry_func2
 * name:         eEntry_func2
 * global_name:  tCell2_active_single_eEntry_func2
 * #[/ENTRY_FUNC>]# */
int32_t
eEntry_func2(int32_t a)
{
}

