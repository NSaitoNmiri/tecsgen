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
 * msg              char_t*          ATTR_msg        
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cPrint  signature: sPrint
 *   void           cPrint_print( char_t* str );
 *
 * #[</PREAMBLE>]# */

#include "tTECSMain_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* <<< */
/* ���Υե������ gen/tTECSMain_templ.c �� src/tTECSMain.c �˰ܤ��ƻ��Ѥ��ޤ� */
/* <<< */

/****** ��������񤭲ä��� ******/
main( )
{
	cPrint_print( ATTR_msg );
}
/****** �����ޤǽ񤭲ä� ******/
