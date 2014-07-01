/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCelltypeCaller_template.c => src/tCelltypeCaller.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * call port : cCall  signature: sSig context: task
 *   struct tagStruct  cCall_func1( struct tagStruct  in, const struct tagStruct * in_p, struct tagStruct * inout_p, struct tagStruct * out_p );
 *   struct tagStruct  cCall_func2( struct tagStruct  in, const struct tagStruct * in_p, struct tagStruct * inout_p, struct tagStruct * out_p, int32_t len );
 *   struct tagStruct  cCall_func3( struct tagStruct2  in, const struct tagStruct2 * in_p, struct tagStruct2 * inout_p, struct tagStruct2 * out_p );
 *   struct tagStruct  cCall_func4( struct tagStruct2  in, const struct tagStruct2 * in_p, struct tagStruct2 * inout_p, struct tagStruct2 * out_p, int32_t len );
 *   struct tagStruct  cCall_func5( struct tagStruct * inp, struct tagStruct ** outp );
 *   struct tagStruct  cCall_func6( struct tagStruct2 * sendp, struct tagStruct2 ** receivep, char_t** strs, char_t*** strr, int32_t* len );
 * allocator port for call port: cCall func: func5 param: inp
 *   ER             cCall_func5_inp_alloc( int32_t size, void** p );
 *   ER             cCall_func5_inp_dealloc( const void* p );
 * allocator port for call port: cCall func: func5 param: outp
 *   ER             cCall_func5_outp_alloc( int32_t size, void** p );
 *   ER             cCall_func5_outp_dealloc( const void* p );
 * allocator port for call port: cCall func: func6 param: sendp
 *   ER             cCall_func6_sendp_alloc( int32_t size, void** p );
 *   ER             cCall_func6_sendp_dealloc( const void* p );
 * allocator port for call port: cCall func: func6 param: receivep
 *   ER             cCall_func6_receivep_alloc( int32_t size, void** p );
 *   ER             cCall_func6_receivep_dealloc( const void* p );
 * allocator port for call port: cCall func: func6 param: strs
 *   ER             cCall_func6_strs_alloc( int32_t size, void** p );
 *   ER             cCall_func6_strs_dealloc( const void* p );
 * allocator port for call port: cCall func: func6 param: strr
 *   ER             cCall_func6_strr_alloc( int32_t size, void** p );
 *   ER             cCall_func6_strr_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

/* �ץ�ȥ�����������ѿ�������򤳤��˽񤭤ޤ� */
#include "tCelltypeCaller_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* success */
#define	E_ID	(-18)	/* illegal ID */
#endif

/* #[<ENTRY_PORT>]# eMain
 * entry port: eMain
 * signature:  sTaskBody
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eMain_main
 * name:         eMain_main
 * global_name:  tCelltypeCaller_eMain_main
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
void
eMain_main(CELLIDX idx)
{
	CELLCB	 *p_cellcb;
	struct   tagStruct *outp;
	struct   tagStruct2 *receiverp;
	char_t   **strr;
	int32_t  len;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */


	CCALL_FUNC5_OUTP_DEALLOC(outp);
	CCALL_FUNC6_RECEIVEP_DEALLOC(receiverp, len);
	CCALL_FUNC6_STRR_DEALLOC(strr, len);

}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
