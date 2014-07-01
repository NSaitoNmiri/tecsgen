/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * �ƤӸ��ؿ� #_TCPF_#
 * allocator port for call port: eEnt func: giftToYou param: buf
 *   ER             eEnt_giftToYou_buf_alloc( int32_t size, void** p );
 *   ER             eEnt_giftToYou_buf_dealloc( const void* ptr );
 * allocator port for call port: eEnt func: returnGiftFromYou param: buf
 *   ER             eEnt_returnGiftFromYou_buf_alloc( int32_t size, void** p );
 *   ER             eEnt_returnGiftFromYou_buf_dealloc( const void* ptr );
 *
 * #[</PREAMBLE>]# */

#include "tSample_tecsgen.h"

#ifndef E_OK
#define	E_OK	0		/* ���ｪλ */
#define	E_ID	(-18)	/* ����ID�ֹ� */
#endif


/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt
 * entry port: eEnt
 * signature:  sSample
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt_sayHello
 * name:         eEnt_sayHello
 * global_name:  tSample_eEnt_sayHello
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_sayHello(CELLIDX idx, int32_t times)
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
	printf( "Sample: " );
	while( times-- > 0 )
		printf( "hello " );
	printf( "\n" );

	return(ercd);
}

/* #[<ENTRY_FUNC>]# eEnt_howAreYou
 * name:         eEnt_howAreYou
 * global_name:  tSample_eEnt_howAreYou
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_howAreYou(CELLIDX idx, char_t* buf, int32_t len)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	printf( "tSample: buf addr: %08x, size: %d\n", buf, len );
	/* �����˽������Τ򵭽Ҥ��ޤ� */
	strncpy( buf, "Sample: I'm fine!", len );

	return(ercd);
}


/* #[<ENTRY_FUNC>]# eEnt_giftToYou
 * name:         eEnt_giftToYou
 * global_name:  tSample_eEnt_giftToYou
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_giftToYou(CELLIDX idx, char_t* buf, int32_t len)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

	printf( "tSample: Gift: %s\n", buf );

	eEnt_giftToYou_buf_dealloc( buf );
	return(ercd);
}

/* #[<ENTRY_FUNC>]# eEnt_returnGiftFromYou
 * name:         eEnt_returnGiftFromYou
 * global_name:  tSample_eEnt_returnGiftFromYou
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
ER
eEnt_returnGiftFromYou(CELLIDX idx, int16_t** buf, int32_t* len)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	int16_t *allocbuf;

	int_t   i;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
#define GIFT_LEN 512
	eEnt_returnGiftFromYou_buf_alloc( GIFT_LEN * sizeof(int16_t), (void **)&allocbuf );
	for( i = 0; i < GIFT_LEN; i++ )
		allocbuf[i] = i;

	*buf = allocbuf;
	*len = GIFT_LEN;
	return(ercd);
}

/* #[<ENTRY_FUNC>]# eEnt_oneway
 * name:         eEnt_oneway
 * global_name:  tSample_eEnt_oneway
 * oneway:       true
 * #[</ENTRY_FUNC>]# */
ER
eEnt_oneway(CELLIDX idx, const int8_t* buf, int16_t len)
{
	CELLCB	*p_cellcb;
	int16_t i;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* oneway �ξ�� E_OK �����֤��ޤ��� */
		return(E_OK);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	printf( "len=%d\n", len );

	for(i=0; i<len; i++){
		printf( "%02X ", (uint8_t)buf[i]);
		if( i % 8 == 7 )
			putchar( '\n' );
	}
	putchar( '\n' );

	/* oneway �ξ�� E_OK �����֤��ޤ��� */
	return(E_OK);
}

/* #[<ENTRY_FUNC>]# eEnt_shutdown
 * name:         eEnt_shutdown
 * global_name:  tSample_eEnt_shutdown
 * oneway:       true
 * #[</ENTRY_FUNC>]# */
void
eEnt_shutdown(CELLIDX idx)
{
	void pthread_exit(void *retval); 

	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	pthread_exit(0);
}

/* #[<POSTAMBLE>]#
 *   �����겼����������ؿ���񤭤ޤ�
 * #[</POSTAMBLE>]#*/
