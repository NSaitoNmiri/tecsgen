#include "tSingleCall_tecsgen.h"

/* �ƤӸ��ؿ� */
/*
 * call port : cSingleEntry  signature: sSingleEntry
 *   tecs_int32 cSingleEntry_single( THIS, tecs_int32 single );
 */

/* �������ؿ� */
main()
{
/* ���ץƥ��ޥ�������Ƥ���Ȥ����Ϥʤ��ʤ�
 * extern tSingleCall_CB    tSingleCall_CB_tab[];
 * struct tag_tSingleCall_CB *p_cellcb = &tSingleCall_CB_tab[0];
 */
  puts( "tSingleCall   main" );

  cSingleEntry_single( 10 );
}
