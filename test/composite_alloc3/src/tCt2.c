/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCt2_template.c => src/tCt2.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSig context: task
 *   ER             cCall_func( int32_t* a );
 *   ER             cCall_func2( int8_t* buf, int32_t sz );
 * allocator port for call port: cCall func: func param: a
 *   ER             cCall_func_a_alloc( int32_t sz, void** p );
 *   ER             cCall_func_a_dealloc( const void* p );
 * allocator port for call port: cCall func: func2 param: buf
 *   ER             cCall_func2_buf_alloc( int32_t sz, void** p );
 *   ER             cCall_func2_buf_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

#include "tCt2_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

main()
{
	int32_t   sz = 32;
	void     *p;

	cCall_func2_buf_alloc( 0, sz, &p );
	strncpy( p, "hello !!", sz );
	cCall_func2( 0, p, sz );

	cCall_func2_buf_alloc( 1, sz, &p );
	strncpy( p, "good-bye !!", sz );
	cCall_func2( 1, p, sz );
}
