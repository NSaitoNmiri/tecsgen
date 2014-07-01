/* #[<PREAMBLE>]#
 * #[<...>]# ���� #[</...>]# �ǰϤޤ줿�����Ȥ��Խ����ʤ��Ǥ�������
 * tecsmerge �ˤ��ޡ����˻��Ѥ���ޤ�
 *
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * ���Υե�������Խ����ƻ��Ѥ��뤳�Ȥ��տޤ���Ƥ��ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tAlloc_template.c => src/tAlloc.c
 * �Τ褦��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 *
 * °�����������ޥ��� #_CAAM_#
 * size             int32_t          ATTR_size       
 * buffer           int8_t*          VAR_buffer      
 * n_alloc          int32_t          VAR_n_alloc     
 * n_dealloc        int32_t          VAR_n_dealloc   
 *
 * #[</PREAMBLE>]# */

#include "tAlloc_tecsgen.h"
#include "stddef.h"

#ifndef E_OK
#define	E_OK		0		/* ���ｪλ */
#define	E_ID		(-18)		/* ����ID�ֹ� */
#endif


/* °�����������ޥ��� */
/*
 * size             int32_t          ATTR_size       
 * buffer           int_least8_t*    VAR_buffer      
 */

/* �ƤӸ��ؿ� */
/*
 */

/* �������ؿ� */
/*
 * entry port: eA
 * signature:  sAlloc
 */
/*
 * name:         eA_alloc
 * global_name:  tAlloc_eA_alloc
 */
ER             eA_alloc( tAlloc_IDX idx, int32_t size, void** p)
{
    tAlloc_CB *p_cellcb;
    if( tAlloc_VALID_IDX( idx ) ){
        p_cellcb = GET_CELLCB(idx);
    }else{
        return E_ID;
    }
    *p = malloc( size );

	VAR_n_alloc++;
	printf( "ALLOC: allocated: %d  deallocated: %d\n", VAR_n_alloc, VAR_n_dealloc );

    /* malloc �� NULL �ʤ� */
    return ( *p != 0 ) ? E_OK: E_NOMEM;
}

/*
 * name:         eA_dealloc
 * global_name:  tAlloc_eA_dealloc
 */
ER             eA_dealloc( tAlloc_IDX idx, const void* p)
{
    ER       ercd_ = E_OK;
    tAlloc_CB *p_cellcb;
    if( tAlloc_VALID_IDX( idx ) ){
        p_cellcb = GET_CELLCB(idx);
    }else{
        return E_ID;
    }
    free( p );

	VAR_n_dealloc++;
	printf( "DEALLOC: allocated: %d  deallocated: %d\n", VAR_n_alloc, VAR_n_dealloc );

    return ercd_;
}

