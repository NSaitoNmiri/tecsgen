#ifndef my_setjmp_h__
#define my_setjmp_h__

/*
 * setjmp.h �����܂���荞�߂Ȃ��������߁A�W�F�l���[�^�̒i�K�ł͉��� jmp_buf �^�Ƃ���
 */

#ifdef TECS
typedef int  jmp_buf[1];
#else
#include <setjmp.h>
#endif

#endif /* my_setjmp_h__ */
