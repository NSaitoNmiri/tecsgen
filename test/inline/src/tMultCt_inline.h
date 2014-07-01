/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * a                int32_t          ATTR_a          
 * v                int32_t          VAR_v           
 *
 * #[</PREAMBLE>]# */

/* �������ؿ� #_TEPF_# */
/* #[<ENTRY_PORT>]# eEnt
 * entry port: eEnt
 * signature:  sSig2
 * context:    task
 * #[</ENTRY_PORT>]# */

/* #[<ENTRY_FUNC>]# eEnt_func2
 * name:         eEnt_func2
 * global_name:  tMultCt_eEnt_func2
 * oneway:       false
 * #[</ENTRY_FUNC>]# */
/*__inline__ int32_t*/
Inline int32_t
eEnt_func2(tMultCt_IDX idx)
{
	CELLCB	*p_cellcb;
	if (VALID_IDX(idx)) {
		p_cellcb = GET_CELLCB(idx);
	}
	else {
		/* ���顼���������ɤ򤳤��˵��Ҥ��ޤ� */
		return 0;
	}

	/* �����˽������Τ򵭽Ҥ��ޤ� */
	printf( "tMultCt_eEnt_func2: v = %d\n", VAR_v );
	VAR_v++;

	return 0;
}

