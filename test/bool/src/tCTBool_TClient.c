/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCTBool_TClient_template.c => src/tCTBool_TClient.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cBooo  signature: sSigBool_T context: task
 *   bool_t         cBooo_func( subscript, bool_t boo, bool_t* boo2 );
 *   bool_t*        cBooo_func2( subscript, const bool_t* boo, int sz );
 *       subscript:  0...(NCP_cBooo-1)
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� #_PAC_# */
#include "tCTBool_TClient_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/

int main( int argc, char **argv )
{
	bool_t		boo2;
#define	BOO_LEN	(2)
	static bool_t		boo[BOO_LEN] = { true, false };
	
	cBooo_func( 0, true, &boo2 );
	cBooo_func( 1, true, &boo2 );


	cBooo_func2( 0, boo, BOO_LEN );
}
