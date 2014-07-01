/* tecs.h */
#ifndef	TECS_H_
#define	TECS_H_

/* gcc-4 $B$GB??t$N(B built-in $B%i%$%V%i%j$H$NIT@09g$N7Y9p$r>C$9$?$a(B */
/* tecsgen $B$N(B C_parser $B$,FI$a$J$$9=J8$,B?$$$?$a(B tecsgen $B<B9T;~$O(B include $B$7$J$$(B */
#ifndef TECS
// #if 0
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>
#endif /* TECS_CPP */

#include <limits.h>
#include <stddef.h>
#include <t_stddef.h>

typedef unsigned char tecs_char;
typedef BOOL tecs_bool;

#ifdef INT_LEAST64_MAX
typedef int_least64_t tecs_int64_t;
typedef uint_least64_t tecs_uint64_t;
#else
typedef struct { long high; long low; } tecs_int64_t;
typedef struct { long high; long low; } tecs_uint64_t;
#endif

#ifdef INT_LEAST128_MAX
typedef int_least128_t tecs_int128;
typedef uint_least128_t tecs_uint128;
#else
typedef struct { tecs_int64_t high; tecs_uint64_t low; } tecs_int128_t;
typedef struct { tecs_uint64_t high; tecs_uint64_t low; } tecs_uint128_t;
#endif

/*
typedef float tecs_float;
typedef double tecs_double;
*/
typedef float  float32_t;
typedef double double64_t;

#define Inline  static inline

#endif	/* ! TECS_H_ */
