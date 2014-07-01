#include "TOPPERS_tKernel_tecsgen.h"

/* �ƤӸ��ؿ� */
/*
 */

/* �������ؿ� */
/*
 * entry port: ka
 * signature:  sSyscall
 */
/*
 * name:         ka_cre_sem
 * global_name:  TOPPERS_tKernel_ka_cre_sem
 */
ER_ID    ka_cre_sem( tKernel_IDX idx)
{
  struct tag_TOPPERS_tKernel_CB *this;
  if( VALID_IDX( idx ) ){
    this = TOPPERS_tKernel_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
}

/*
 * name:         ka_wai_sem
 * global_name:  TOPPERS_tKernel_ka_wai_sem
 */
ER       ka_wai_sem( tKernel_IDX idx, ID id)
{
  struct tag_TOPPERS_tKernel_CB *this;
  if( VALID_IDX( idx ) ){
    this = TOPPERS_tKernel_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
}

/*
 * name:         ka_rel_sem
 * global_name:  TOPPERS_tKernel_ka_rel_sem
 */
ER       ka_rel_sem( tKernel_IDX idx, ID id)
{
  struct tag_TOPPERS_tKernel_CB *this;
  if( VALID_IDX( idx ) ){
    this = TOPPERS_tKernel_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
}

/*
 * name:         ka_del_sem
 * global_name:  TOPPERS_tKernel_ka_del_sem
 */
ER       ka_del_sem( tKernel_IDX idx, ID id)
{
  struct tag_TOPPERS_tKernel_CB *this;
  if( VALID_IDX( idx ) ){
    this = TOPPERS_tKernel_GET_CELLCB(idx);
  }else{
     /* ���顼���������ɤ򤳤��˵��� */
  }
}

