#include "tCell_serv_tecsgen.h"

/* �ƤӸ��ؿ� */
/*
 */

/* �������ؿ� */
/*
 * entry port: eEntry
 * signature:  sSig5
 */
/*
 * name:         eEntry_func1
 * global_name:  tCell_serv_eEntry_func1
 */
tecs_int32 eEntry_func1( tCell_serv_IDX idx, tecs_int32 a)
{
  tCell_serv_CB   *p_cellcb;
  if( VALID_IDX( idx ) ){
    p_cellcb = tCell_serv_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
  printf( "tCell_serv: eEntry_func1( a=%d )\n", a );
}

/*
 * name:         eEntry_func2
 * global_name:  tCell_serv_eEntry_func2
 */
tecs_int32 eEntry_func2( tCell_serv_IDX idx, tecs_int32 a)
{
  tCell_serv_CB   *p_cellcb;
  if( VALID_IDX( idx ) ){
    p_cellcb = tCell_serv_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
  printf( "tCell_serv: eEntry_func2( a=%d )\n", a );
}
