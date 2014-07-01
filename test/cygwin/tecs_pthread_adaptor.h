#ifndef _tecs_pthread_adaptor_h_
#define _tecs_pthread_adaptor_h_

/*
 * pthread.h �� tecsgen �������ʤ�����λ����к�
 * pthread.h �˴ޤޤ�� union ���б����Ƥ��ʤ����ᡢ����ळ�Ȥ��Ǥ��ʤ�
 */

#ifdef TECS
/* tecsgen �����ɤ߹��ޤ�Ƥ��� */

typedef intptr_t  pthread_task_t;
typedef intptr_t  pthread_mutex_t;
typedef intptr_t  pthread_once_t;
typedef intptr_t  pthread_cond_t;

#else
/* tecsgen �ʳ� (gcc) �����ɤ߹��ޤ�Ƥ��� */

#include "pthread.h"

#endif

#endif /* _tecs_pthread_adaptor_h_ */
