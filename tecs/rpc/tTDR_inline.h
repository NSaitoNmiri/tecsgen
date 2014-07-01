/*
 *  TECS Generator
 *      Generator for TOPPERS Embedded Component System
 *  
 *   Copyright (C) 2008-2013 by TOPPERS Project
 *--
 *   �嵭����Ԥϡ��ʲ���(1)(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
 *   �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
 *   �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *   (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *       ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *       ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *   (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *       �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *       ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *   (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *       �ȡ�
 *     (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *         �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *     (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ������Ȥ�
 *         ��𤹤뤳�ȡ�
 *   (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *       ������⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ����դ��뤳�ȡ�
 *       �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
 *       ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ�
 *       ���դ��뤳�ȡ�
 *  
 *   �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *   ���TOPPERS�ץ������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
 *   ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
 *   �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
 *   ����Ǥ�����ʤ���
 *  
 *   $Id: tTDR_inline.h 1925 2013-01-20 05:55:58Z okuma-top $
 */

/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * tmo              TMO              VAR_tmo         
 *
 * #[</PREAMBLE>]# */

/*
 * marhaler, unmarshaler �����Ѥ��� STRLEN �ؿ����������
 *  marshaler, unmarshaler ��ɬ�� TDR �� �˷�礵��뤿��
 */
#include	"rpc_string.h"

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eTDR
 * entry port: eTDR
 * signature:  sTDR
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eTDR_reset
 * name:         eTDR_reset
 * global_name:  tTDR_eTDR_reset
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_reset(CELLIDX idx)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	syslog( LOG_INFO, "TDR: resetting channel" );
	ercd = cChannel_reset();
	return(ercd);
}

/* #[<ENTRY_FUNC>]# eTDR_sendSOP
 * name:         eTDR_sendSOP
 * global_name:  tTDR_eTDR_sendSOP
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_sendSOP(CELLIDX idx, bool_t b_client )
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	const uint16_t *p_sopMagic;
	const uint16_t SOP_MAGIC1 = TDR_SOP_MAGIC1;
	const uint16_t SOP_MAGIC2 = TDR_SOP_MAGIC2;
	uint8_t		   val;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
#ifdef RPC_DEBUG
	syslog(LOG_INFO, "eTDR_sendSOP(b_client=%d)", b_client);
#endif
    if( b_client )
		p_sopMagic = &SOP_MAGIC1;
	else
		p_sopMagic = &SOP_MAGIC2;

	/*
	 * SOP �ѥ��åȤ�����
	 * �ѥ��åȥ������󥹤�¿������Ƥ�����Ǥ���褦�ˡ��Х���ñ�̤�����
	 * ���̥��ɥ쥹����̥��ɥ쥹�ν������
	 */

	val = (uint8_t)(*((uint8_t *)p_sopMagic));
	ercd = eTDR_putUInt8( idx, val );
	// syslog( LOG_INFO, "sendSOP:1 %02X", val );
	if( ercd != E_OK )
		return	ercd;
	val = (uint8_t)*(((uint8_t *)p_sopMagic)+1);
	ercd = eTDR_putUInt8( idx, val );
	// syslog( LOG_INFO, "sendSOP:2 %02X", val );

	return	ercd;
}

/* #[<ENTRY_FUNC>]# eTDR_receiveSOP
 * name:         eTDR_receiveSOP
 * global_name:  tTDR_eTDR_receiveSOP
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_receiveSOP(CELLIDX idx, bool_t b_client)
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	const uint16_t SOP_MAGIC1 = TDR_SOP_MAGIC1;
	const uint16_t SOP_MAGIC2 = TDR_SOP_MAGIC2;
	const uint16_t *p_sopMagic;
	uint16_t magic;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
#ifdef RPC_DEBUG
	syslog(LOG_INFO, "eTDR_receiveSOP(b_client=%d)", b_client);
#endif

    if( b_client )
		p_sopMagic = &SOP_MAGIC2;
	else
		p_sopMagic = &SOP_MAGIC1;

	if( (ercd=eTDR_getUInt8( idx, (uint8_t *)&magic )) != E_OK )
		;
	else if( (uint8_t)magic != (uint8_t)(*((uint8_t *)p_sopMagic)) ){
		// syslog( LOG_INFO, "receiveSOP:1 %02X expecting=%02X", (uint8_t)magic, (int8_t)(*((int8_t *)p_sopMagic)) );
		ercd = E_MAGIC;
	}
	else if((ercd=eTDR_getUInt8( idx, ((uint8_t *)&magic)+1 )) != E_OK )
		;
	else if( magic != *p_sopMagic){
		// syslog( LOG_INFO, "receiveSOP:2 %04X expecting=%04X", magic, *p_sopMagic );
		ercd = E_MAGIC;
	}

	if( ercd != E_OK )
		syslog( LOG_INFO, "receiveSOP: ERCD=%d", ercd );

	return ercd;
}

/* #[<ENTRY_FUNC>]# eTDR_sendEOP
 * name:         eTDR_sendEOP
 * global_name:  tTDR_eTDR_sendEOP
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_sendEOP(CELLIDX idx, bool_t b_continue )
{
	ER		ercd = E_OK;
	CELLCB	*p_cellcb;
	uint16_t magic;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
#ifdef RPC_DEBUG
	syslog(LOG_INFO, "eTDR_sendEOP(b_continue=%d)", b_continue);
#endif

	if( b_continue )
		magic = TDR_EOP_MAGIC1;
	else
		magic = TDR_EOP_MAGIC2;

	/* EOP magic ������ */
	if( (ercd = eTDR_putInt16( idx, (int16_t)magic )) != E_OK )
		return ercd;

	return cChannel_flush(VAR_tmo);
}

/* #[<ENTRY_FUNC>]# eTDR_receiveEOP
 * name:         eTDR_receiveEOP
 * global_name:  tTDR_eTDR_receiveEOP
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_receiveEOP(CELLIDX idx, bool_t b_continue)
{
	ER		ercd = E_OK, er2;
	CELLCB	*p_cellcb;
	uint16_t magic;

	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
#ifdef RPC_DEBUG
	syslog(LOG_INFO, "eTDR_receiveEOP(b_continue=%d)",b_continue);
#endif
/* mikan cChannel EOF get_* */
/* mikan magic EOF */

	if( (ercd=eTDR_getInt16( idx, (int16_t *)&magic )) == E_OK ){
		if( (b_continue && magic == TDR_EOP_MAGIC1) || (!b_continue && magic == TDR_EOP_MAGIC2) ){
		} else {
			ercd = E_MAGIC;
		}
	}
	er2 = cChannel_end_receive();
	return ercd != E_OK ? ercd : er2;
}

/* #[<ENTRY_FUNC>]# eTDR_putInt8
 * name:         eTDR_putInt8
 * global_name:  tTDR_eTDR_putInt8
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt8(CELLIDX idx, int8_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putInt16
 * name:         eTDR_putInt16
 * global_name:  tTDR_eTDR_putInt16
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt16(CELLIDX idx, int16_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putInt32
 * name:         eTDR_putInt32
 * global_name:  tTDR_eTDR_putInt32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt32(CELLIDX idx, int32_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putInt64
 * name:         eTDR_putInt64
 * global_name:  tTDR_eTDR_putInt64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt64(CELLIDX idx, int64_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putInt128
 * name:         eTDR_putInt128
 * global_name:  tTDR_eTDR_putInt128
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt128(CELLIDX idx, int128_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt8
 * name:         eTDR_getInt8
 * global_name:  tTDR_eTDR_getInt8
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt8(CELLIDX idx, int8_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	 *p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt16
 * name:         eTDR_getInt16
 * global_name:  tTDR_eTDR_getInt16
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt16(CELLIDX idx, int16_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt32
 * name:         eTDR_getInt32
 * global_name:  tTDR_eTDR_getInt32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt32(CELLIDX idx, int32_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt64
 * name:         eTDR_getInt64
 * global_name:  tTDR_eTDR_getInt64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt64(CELLIDX idx, int64_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt128
 * name:         eTDR_getInt128
 * global_name:  tTDR_eTDR_getInt128
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt128(CELLIDX idx, int128_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt8
 * name:         eTDR_putUInt8
 * global_name:  tTDR_eTDR_putUInt8
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt8(CELLIDX idx, uint8_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt16
 * name:         eTDR_putUInt16
 * global_name:  tTDR_eTDR_putUInt16
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt16(CELLIDX idx, uint16_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt32
 * name:         eTDR_putUInt32
 * global_name:  tTDR_eTDR_putUInt32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt32(CELLIDX idx, uint32_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt64
 * name:         eTDR_putUInt64
 * global_name:  tTDR_eTDR_putUInt64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt64(CELLIDX idx, uint64_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt128
 * name:         eTDR_putUInt128
 * global_name:  tTDR_eTDR_putUInt128
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt128(CELLIDX idx, uint128_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt8
 * name:         eTDR_getUInt8
 * global_name:  tTDR_eTDR_getUInt8
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt8(CELLIDX idx, uint8_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt16
 * name:         eTDR_getUInt16
 * global_name:  tTDR_eTDR_getUInt16
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt16(CELLIDX idx, uint16_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt32
 * name:         eTDR_getUInt32
 * global_name:  tTDR_eTDR_getUInt32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt32(CELLIDX idx, uint32_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt64
 * name:         eTDR_getUInt64
 * global_name:  tTDR_eTDR_getUInt64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt64(CELLIDX idx, uint64_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt128
 * name:         eTDR_getUInt128
 * global_name:  tTDR_eTDR_getUInt128
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt128(CELLIDX idx, uint128_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putFloat32
 * name:         eTDR_putFloat32
 * global_name:  tTDR_eTDR_putFloat32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putFloat32(CELLIDX idx, float32_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putDouble64
 * name:         eTDR_putDouble64
 * global_name:  tTDR_eTDR_putDouble64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putDouble64(CELLIDX idx, double64_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getFloat32
 * name:         eTDR_getFloat32
 * global_name:  tTDR_eTDR_getFloat32
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getFloat32(CELLIDX idx, float32_t* out)
{
	ER_UINT		er_sz = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getDouble64
 * name:         eTDR_getDouble64
 * global_name:  tTDR_eTDR_getDouble64
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getDouble64(CELLIDX idx, double64_t* out)
{
	ER_UINT		er_sz = E_OK;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putChar
 * name:         eTDR_putChar
 * global_name:  tTDR_eTDR_putChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putChar(CELLIDX idx, char_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getChar
 * name:         eTDR_getChar
 * global_name:  tTDR_eTDR_getChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getChar(CELLIDX idx, char_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putSChar
 * name:         eTDR_putSChar
 * global_name:  tTDR_eTDR_putSChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putSChar(CELLIDX idx, signed char in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putShort
 * name:         eTDR_putShort
 * global_name:  tTDR_eTDR_putShort
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putShort(CELLIDX idx, short_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putInt
 * name:         eTDR_putInt
 * global_name:  tTDR_eTDR_putInt
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putInt(CELLIDX idx, int_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putLong
 * name:         eTDR_putLong
 * global_name:  tTDR_eTDR_putLong
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putLong(CELLIDX idx, long_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getSChar
 * name:         eTDR_getSChar
 * global_name:  tTDR_eTDR_getSChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getSChar(CELLIDX idx, signed char* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getShort
 * name:         eTDR_getShort
 * global_name:  tTDR_eTDR_getShort
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getShort(CELLIDX idx, short* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getInt
 * name:         eTDR_getInt
 * global_name:  tTDR_eTDR_getInt
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getInt(CELLIDX idx, int_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getLong
 * name:         eTDR_getLong
 * global_name:  tTDR_eTDR_getLong
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getLong(CELLIDX idx, long_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putUChar
 * name:         eTDR_putUChar
 * global_name:  tTDR_eTDR_putUChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUChar(CELLIDX idx, unsigned char in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUShort
 * name:         eTDR_putUShort
 * global_name:  tTDR_eTDR_putUShort
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUShort(CELLIDX idx, ushort_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putUInt
 * name:         eTDR_putUInt
 * global_name:  tTDR_eTDR_putUInt
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putUInt(CELLIDX idx, uint_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_putULong
 * name:         eTDR_putULong
 * global_name:  tTDR_eTDR_putULong
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putULong(CELLIDX idx, ulong_t in)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&in, (int16_t)sizeof( in ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getUChar
 * name:         eTDR_getUChar
 * global_name:  tTDR_eTDR_getUChar
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUChar(CELLIDX idx, unsigned char* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUShort
 * name:         eTDR_getUShort
 * global_name:  tTDR_eTDR_getUShort
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUShort(CELLIDX idx, unsigned short* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getUInt
 * name:         eTDR_getUInt
 * global_name:  tTDR_eTDR_getUInt
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getUInt(CELLIDX idx, uint_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_getULong
 * name:         eTDR_getULong
 * global_name:  tTDR_eTDR_getULong
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getULong(CELLIDX idx, ulong_t* out)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)out, (int16_t)sizeof( *out ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *out ) ? E_OK : E_BOVR );
}

/* #[<ENTRY_FUNC>]# eTDR_putIntptr
 * name:         eTDR_putIntptr
 * global_name:  tTDR_eTDR_putIntptr
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_putIntptr(CELLIDX idx, const intptr_t ptr)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	return cChannel_send( (int8_t *)&ptr, (int16_t)sizeof( ptr ), VAR_tmo );
}

/* #[<ENTRY_FUNC>]# eTDR_getIntptr
 * name:         eTDR_getIntptr
 * global_name:  tTDR_eTDR_getIntptr
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline ER
eTDR_getIntptr(CELLIDX idx, intptr_t* ptr)
{
	ER_UINT	 er_sz;
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		return(E_ID);
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */
	er_sz = cChannel_receive( (int8_t *)ptr, (int16_t)sizeof( *ptr ), VAR_tmo );
	return  er_sz < 0 ? er_sz : ( er_sz == sizeof( *ptr ) ? E_OK : E_BOVR );
}


