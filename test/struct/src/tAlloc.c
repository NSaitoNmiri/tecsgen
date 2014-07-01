/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 */

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
ER             eAlloc_alloc( tAlloc_IDX idx, int32_t size, void** p)
{
    tAlloc_CB *p_cellcb;
    if( tAlloc_VALID_IDX( idx ) ){
        p_cellcb = GET_CELLCB(idx);
    }else{
        return E_ID;
    }
    *p = malloc( size );

    /* malloc �� NULL �ʤ� */
    return ( *p != 0 ) ? E_OK: E_NOMEM;
}

/*
 * name:         eA_dealloc
 * global_name:  tAlloc_eA_dealloc
 */
ER             eAlloc_dealloc( tAlloc_IDX idx, const void* p)
{
    ER       ercd_ = E_OK;
    tAlloc_CB *p_cellcb;
    if( tAlloc_VALID_IDX( idx ) ){
        p_cellcb = GET_CELLCB(idx);
    }else{
        return E_ID;
    }
    free( p );
    return ercd_;
}

