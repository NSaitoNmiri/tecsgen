/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tAlarm_inline_template.h => src/tAlarm_inline.h
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */
/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * id               uint8_t          ATTR_id         
 *
 * #[</PREAMBLE>]# */

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eAlarm
 * entry port: eAlarm
 * signature:  sAlarm
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eAlarm_getBase
 * name:         eAlarm_getBase
 * global_name:  tAlarm_eAlarm_getBase
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline uint8_t
eAlarm_getBase(CELLIDX idx, uint8_t* p_info)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eAlarm_get
 * name:         eAlarm_get
 * global_name:  tAlarm_eAlarm_get
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline uint8_t
eAlarm_get(CELLIDX idx, uint8_t* p_tick)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eAlarm_setRelative
 * name:         eAlarm_setRelative
 * global_name:  tAlarm_eAlarm_setRelative
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline uint8_t
eAlarm_setRelative(CELLIDX idx, uint8_t incr, uint8_t cycle)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eAlarm_setAbsolute
 * name:         eAlarm_setAbsolute
 * global_name:  tAlarm_eAlarm_setAbsolute
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline uint8_t
eAlarm_setAbsolute(CELLIDX idx, uint8_t start, uint8_t cycle)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

/* #[<ENTRY_FUNC>]# eAlarm_cancel
 * name:         eAlarm_cancel
 * global_name:  tAlarm_eAlarm_cancel
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
Inline uint8_t
eAlarm_cancel(CELLIDX idx)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
	} /* end if VALID_IDX(idx) */

	/* �����˽������Τ򵭽Ҥ��ޤ� #_TEFB_# */

}

