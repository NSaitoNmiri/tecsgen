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
 * call port : cMain  signature: sMain
 *   ER             cMain_main( subscript );
 *
 * #[</PREAMBLE>]# */

#include "tMain_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

main()
{
	int   i;

/* -R ����ꤷ�����˽������ɬ�� */
#ifdef INITIALZE_TECSGEN
	INITIALZE_TECSGEN()
#endif

	for( i = 0; i < N_CP_cMain; i++ )
		cMain_main(i);
}
