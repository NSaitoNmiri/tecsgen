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
 * a                int32_t          ATTR_a          
 * b                int32_t          VAR_b           
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSig
 *   int32_t        cCall_func( subscript, int32_t in, int32_t* out );
 *
 * #[</PREAMBLE>]# */

#include "tSingle_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eSig
 * entry port: eSig
 * signature:  sSig
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eSig_func
 * name:         eSig_func
 * global_name:  tSingle_eSig_func
 * #[/ENTRY_FUNC>]# */
int32_t
eSig_func(int32_t in, int32_t* out)
{
	printf( "Single: attribute a: %d, var b: %d\n", ATTR_a, VAR_b );
}
