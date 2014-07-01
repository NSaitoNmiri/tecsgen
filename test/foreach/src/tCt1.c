/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 * tecsgen �κƼ¹Ԥˤ���񤭤���Ƥ��ޤ����ᡢ�̾�
 *   gen/tCt1_template.c => src/tCt1.c
 * ��̾��, �ե�������ѹ����Ƥ��齤�����ޤ�
 */

#include "tCt1_tecsgen.h"

#ifndef E_OK
#define	E_OK		0		/* ���ｪλ */
#define	E_ID		(-18)		/* ����ID�ֹ� */
#endif


/* °�����������ޥ��� */
/*
 * name             tecs_char*       ATTR_name       
 * a                int32_t          ATTR_a          
 * b                int_t            ATTR_b          
 * a0               int32_t          VAR_a0          
 * b0               int16_t          VAR_b0          
 */

/* �ƤӸ��ؿ� */
/*
 * call port : cC  signature: sSig
 *   ER             cC_func( int_least8_t a );
 */

main()
{
    int  i;
    CELLCB  *p_cellcb;
    FOREACH_CELL(i,p_cellcb)
        CELLCB   *p;
        int      j;

	    printf( "name='%s': a=%d, b=%d\n", ATTR_name, ATTR_a, ATTR_b );
        cC_func( (int_least8_t)ATTR_a );

        FOREACH_CELL(j,p)
        if ( ATTR_a == tCt1_ATTR_a( p ) ) {
            printf( "ATTR_a match : %d\n", ATTR_a );
        } else {
            printf( "ATTR_a mismatch : %d  %d\n", ATTR_a, tCt1_ATTR_a( p ) );
		}
        END_FOREACH_CELL

    END_FOREACH_CELL
}
