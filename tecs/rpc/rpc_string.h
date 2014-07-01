/*
 *
 *  TECS Generator
 *      Generator for TOPPERS Embedded Component System
 *  
 *   Copyright (C) 2008-2013 by TOPPERS Project
 *--
 *   �嵭����Ԥϡ��ʲ���(1)��(4)�ξ������������˸¤ꡤ�ܥ��եȥ���
 *   �����ܥ��եȥ���������Ѥ�����Τ�ޤࡥ�ʲ�Ʊ���ˤ���ѡ�ʣ������
 *   �ѡ������ۡʰʲ������ѤȸƤ֡ˤ��뤳�Ȥ�̵���ǵ������롥
 *   (1) �ܥ��եȥ������򥽡��������ɤη������Ѥ�����ˤϡ��嵭������
 *       ��ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ��꤬�����Τޤޤη��ǥ���
 *       ����������˴ޤޤ�Ƥ��뤳�ȡ�
 *   (2) �ܥ��եȥ������򡤥饤�֥������ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ�����Ǻ����ۤ�����ˤϡ������ۤ�ȼ���ɥ�����ȡ�����
 *       �ԥޥ˥奢��ʤɡˤˡ��嵭�����ɽ�����������Ѿ�浪��Ӳ���
 *       ��̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *   (3) �ܥ��եȥ������򡤵�����Ȥ߹���ʤɡ�¾�Υ��եȥ�������ȯ�˻�
 *       �ѤǤ��ʤ����Ǻ����ۤ�����ˤϡ����Τ����줫�ξ�����������
 *       �ȡ�
 *     (a) �����ۤ�ȼ���ɥ�����ȡ����Ѽԥޥ˥奢��ʤɡˤˡ��嵭����
 *         �ɽ�����������Ѿ�浪��Ӳ�����̵�ݾڵ����Ǻܤ��뤳�ȡ�
 *     (b) �����ۤη��֤��̤�������ˡ�ˤ�äơ�TOPPERS�ץ������Ȥ�
 *         ��𤹤뤳�ȡ�
 *   (4) �ܥ��եȥ����������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������뤤���ʤ�»
 *       ������⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ����դ��뤳�ȡ�
 *       �ޤ����ܥ��եȥ������Υ桼���ޤ��ϥ���ɥ桼������Τ����ʤ���
 *       ͳ�˴�Ť����ᤫ��⡤�嵭����Ԥ����TOPPERS�ץ������Ȥ�
 *       ���դ��뤳�ȡ�
 *  
 *   �ܥ��եȥ������ϡ�̵�ݾڤ��󶡤���Ƥ����ΤǤ��롥�嵭����Ԥ�
 *   ���TOPPERS�ץ������Ȥϡ��ܥ��եȥ������˴ؤ��ơ�����λ�����Ū
 *   ���Ф���Ŭ������ޤ�ơ������ʤ��ݾڤ�Ԥ�ʤ����ޤ����ܥ��եȥ���
 *   �������Ѥˤ��ľ��Ū�ޤ��ϴ���Ū�������������ʤ�»���˴ؤ��Ƥ⡤��
 *   ����Ǥ�����ʤ���
 *  
 *   $Id: rpc_string.h 1925 2013-01-20 05:55:58Z okuma-top $
 */
#ifndef RPC_STRING_H
#define RPC_STRING_H

#include <string.h>

/* GenParamCopy.rb ���������� STRLEN, STRNLEN �ؿ������ */
/* �����Ǥ� short, int, long, int128_t �򥵥ݡ��Ȥ��ʤ� */

#define   STRLEN8( str )    strlen( (char *)str )

/*
 * STRNLEN
 *  marshaler, unmarshaler �� strnlen ��Ȥ���
 *  �Хåե������С����ؤ����������Τˤ��뤿�ᡥ
 *  ��������strnlen �� ANSI-C ɸ��Υ饤�֥��ؿ��ǤϤʤ����ᡢ��������Ƥ��ʤ�������������
 *  GNU (Linux), VC++ �Ǥϻ��ѤǤ��뤬��MacOS �Ǥϻ��ѤǤ��ʤ�
 *  ��¾���ȹ����� OS �Ǥμ���������������
 *  �����ʴؿ��Ǥ���Τ� inline �ؿ��Ȥ��Ƽ������Ƥ���
 */

#ifndef USE_STRNLEN_LIB
#define   STRNLEN8( str, n )    strnlen( (char *)str, n )

#else

Inline size_t
#define   STRNLEN8( str, n )    STRNLEN8_( (uint8_t *)str, n )
STRNLEN8_(const uint8_t *s, size_t maxlen)
{
    size_t  i;
    for( i = 0; i < maxlen; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

#endif

#define	STRLEN16( s )			STRLEN16_( (uint16_t *)s )
#define	STRLEN32( s )			STRLEN32_( (uint32_t *)s )
#define	STRLEN64( s )			STRLEN64_( (uint64_t *)s )

#define	STRNLEN16( s, maxlen )	STRLEN16_( (uint16_t *)s, maxlen )
#define	STRNLEN32( s, maxlen )	STRLEN32_( (uint32_t *)s, maxlen )
#define	STRNLEN64( s, maxlen )	STRLEN64_( (uint64_t *)s, maxlen )

/** STRLENnn_ nn:16,32,64**/
Inline size_t
STRLEN16_(const uint16_t *s )
{
    size_t  i;
    for( i = 0; ; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

Inline size_t
STRLEN32_(const uint32_t *s )
{
    size_t  i;
    for( i = 0; ; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

Inline size_t
STRLEN64_(const uint64_t *s )
{
    size_t  i;
    for( i = 0; ; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

/** STRNLENnn_ nn:16,32,64**/
Inline size_t
STRNLEN16_(const uint16_t *s, size_t maxlen)
{
    size_t  i;
    for( i = 0; i < maxlen; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

Inline size_t
STRNLEN32_(const uint32_t *s, size_t maxlen)
{
    size_t  i;
    for( i = 0; i < maxlen; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}

Inline size_t
STRNLEN64_(const uint64_t *s, size_t maxlen)
{
    size_t  i;
    for( i = 0; i < maxlen; i++ )
        if( *s++ == 0 )
            break;

    return  i;
}


#endif /* RPC_STRING_H */
