/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tTargetComponent_template.c => src/tTargetComponent.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * allocator port for call port: eS func: snd param: buf
 *   ER             eS_snd_buf_alloc( int32_t size, void** p );
 *   ER             eS_snd_buf_dealloc( const void* p );
 * allocator port for call port: eS func: rcv param: buf
 *   ER             eS_rcv_buf_alloc( int32_t size, void** p );
 *   ER             eS_rcv_buf_dealloc( const void* p );
 *
 * #[</PREAMBLE>]# */

#include "tTargetComponent_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eS
 * entry port: eS
 * signature:  sSendRecvp
 * context:    task
 * params: 
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eS_snd
 * name:         eS_snd
 * global_name:  tTargetComponent_eS_snd
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eS_snd(CELLIDX idx, int8_t* buf, int32_t sz)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	puts( buf );

    eS_snd_buf_dealloc( buf );

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eS_rcv
 * name:         eS_rcv
 * global_name:  tTargetComponent_eS_rcv
 * oneway:       
 * #[/ENTRY_FUNC>]# */
ER
eS_rcv(CELLIDX idx, int8_t** buf, int32_t* sz)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
#define STR  "cS_rcv :  message in allocated memoery for receive"

    *sz = 256;
	if( eS_rcv_buf_alloc( *sz, (void **)buf ) != E_OK ){
		return E_NOMEM;
	}
	memset( *buf, 0, *sz );
	memcpy( *buf, STR, sizeof( STR ) );

	return(ercd);
}

