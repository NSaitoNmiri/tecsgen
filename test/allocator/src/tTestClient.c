/*
 * ���Υե������ tecsgen �ˤ��ƥ�ץ졼�ȤȤ��Ƽ�ư��������ޤ���
 */

#include "tTestClient_tecsgen.h"

/* stdio.h �� int_least*_t �κ�������顼�Ȥʤ�Τ� include ���ʤ� */
/* #include <stdio.h> */


#ifndef E_OK
#define	E_OK		0		/* ���ｪλ */
#define	E_ID		(-18)		/* ����ID�ֹ� */
#endif

/* �ƤӸ��ؿ� */
/*
 * call port : cS  signature: sSendRecv
 *   ER             cS_snd( int_least8_t* buf, int32_t sz );
 *   ER             cS_rcv( int_least8_t** buf, int32_t* sz );
 * call port : cA  signature: sSendRecv
 *   ER             cA_snd( subscript, int_least8_t* buf, int32_t sz );
 *   ER             cA_rcv( subscript, int_least8_t** buf, int32_t* sz );
 * call port : cS_snd_buf  signature: sAlloc
 *   ER             cS_snd_buf_alloc( int32_t size, void** p );
 *   ER             cS_snd_buf_dealloc( void* p );
 * call port : cS_rcv_buf  signature: sAlloc
 *   ER             cS_rcv_buf_alloc( int32_t size, void** p );
 *   ER             cS_rcv_buf_dealloc( void* p );
 * call port : cA_snd_buf  signature: sAlloc
 *   ER             cA_snd_buf_alloc( subscript, int32_t size, void** p );
 *   ER             cA_snd_buf_dealloc( subscript, void* p );
 * call port : cA_rcv_buf  signature: sAlloc
 *   ER             cA_rcv_buf_alloc( subscript, int32_t size, void** p );
 *   ER             cA_rcv_buf_dealloc( subscript, void* p );
 */

/* �������ؿ� */

int main( int argc, char **argv )
{
    int_least8_t   *buf;
	int_least32_t   size;
#define BUF_SZ  256
#define STR  "cS_snd :  message in allocated memoery for send"

	if( cS_snd_buf_alloc( BUF_SZ, (void **)&buf ) != E_OK ){
#define MSG "cS_snd_buf_alloc() : failed"
		puts( MSG );
		exit( 1 );
	}

	memset( buf, 0, BUF_SZ );
    memcpy( buf, STR, sizeof( STR ) );
    cS_snd( buf, 256 );

    if( cS_rcv( &buf, &size ) == E_OK ){
		puts( buf );
		cS_rcv_buf_dealloc( buf );
	}


	if( cA_snd_buf_alloc( 0, BUF_SZ, (void **)&buf ) != E_OK ){
#define MSG2 "cA_snd_buf_alloc() : failed"
		puts( MSG );
		exit( 1 );
	}

#define STR2  "cA_snd[0] :  message in allocated memoery for send"
	memset( buf, 0, BUF_SZ );
    memcpy( buf, STR2, sizeof( STR2 ) );
    cA_snd( 0, buf, 256 );

    if( cA_rcv( 1, &buf, &size ) == E_OK ){
		puts( buf );
		cA_rcv_buf_dealloc( 1, buf );
	}

}

