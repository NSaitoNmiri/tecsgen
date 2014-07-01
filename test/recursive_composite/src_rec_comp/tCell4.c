#include "tCell4_tecsgen.h"

/* �ƤӸ��ؿ� */
/*
 * call port : cCall4  signature: sSig5
 *   tecs_int32 cCall4_func1( THIS, tecs_int32 a );
 *   tecs_int32 cCall4_func2( THIS, tecs_int32 a );
 */

/* �������ؿ� */
/*
 * entry port: eEntry4
 * signature:  sSig4
 */
/*
 * name:         eEntry4_func1
 * global_name:  tCell4_eEntry4_func1
 */
tecs_int32 eEntry4_func1( tCell4_IDX idx, tecs_int32 a)
{
  CELLCB      *p_cellcb;
  if( VALID_IDX( idx ) ){
    p_cellcb = tCell4_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }

  printf( "tCell4: eEntry4_func1( a=%d )\n", a );
  printf( "tCell4: eEntry4_func1: calling cCall4_func1( this, a=104 )\n" );
  cCall4_func1( 104 );
}

/*
 * name:         eEntry4_func2
 * global_name:  tCell4_eEntry4_func2
 */
tecs_int32 eEntry4_func2( tCell4_IDX idx, tecs_int32 a)
{
  CELLCB      *p_cellcb;
  if( VALID_IDX( idx ) ){
    p_cellcb = tCell4_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }

  printf( "tCell4: eEntry4_func2( a=%d )\n", a );
  printf( "tCell4: eEntry4_func2: calling cCall4_func2( this, a=204 )\n" );
  cCall4_func2( 204 );
}

