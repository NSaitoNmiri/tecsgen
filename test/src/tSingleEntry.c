#include "tSingleEntry_tecsgen.h"

/* �ƤӸ��ؿ� */
/*
 */

/* �������ؿ� */
/*
 * entry port: eSingleCall
 * signature:  sSingleCall
 */
/*
 * name:         eSingleCall_single
 * global_name:  tSingleEntry_eSingleCall_single
 */
tecs_int32 eSingleCall_single( tSingleEntry_IDX idx, tecs_int32 single)
{
  CELLCB     *this;
  if( VALID_IDX( idx ) ){
    this = tSingleEntry_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }

  puts( "tSingleEntry  eSingleCall_single" );
}

