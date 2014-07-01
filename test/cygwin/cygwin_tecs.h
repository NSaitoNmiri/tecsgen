#ifndef __cygwin_tecs_h__
#define __cygwin_tecs_h__

/* gcc-4 ��¿���� built-in �饤�֥��Ȥ�������ηٹ��ä����� */
/* tecsgen �� C_parser ���ɤ�ʤ���ʸ��¿������ tecsgen �¹Ի��� include ���ʤ� */
#ifndef TECS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>
#endif /* TECS_CPP */

#include "kernel.h"
#include "tecs.h"
#include "tecs_pthread_adaptor.h"

#if 0

// tecs_rpc.h �˰�ư
#ifdef INT_LEAST128_MAX
typedef int_least128_t tecs_int128;
typedef uint_least128_t tecs_uint128;
#else
typedef struct { int64_t high; uint64_t low; } int128_t;
typedef struct { uint64_t high; uint64_t low; } uint128_t;
#endif

// tecs_rpc.h �˰�ư
#define E_RPC     (-67)
#define E_RESET   (-68)
#define E_MAGIC   (-69)
#endif

#endif /* __cygwin_tecs_h__ */


