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
 * v                int32_t          VAR_v           
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall0  signature: sSig
 *   int32_t        cCall0_func( int32_t in, int32_t* out );
 * call port : cCall1  signature: sSig
 *   int32_t        cCall1_func( int32_t in, int32_t* out );
 *
 * #[</PREAMBLE>]# */

#include "tCt2_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

