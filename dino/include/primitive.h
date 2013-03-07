#ifndef __PRIMITIVE__
#define __PRIMITIVE__

#include "dinoscheme.h"
#include "register.h"
#include "memory.h"
#include "util.h"

#define SIZE_PRIMITIVE    0xA

#define ME                0x0 /* MEMORY     */
#define WD                0x1 /* WRITE DATA */
#define LD                0x2 /* LOAD DATA  */
#define GT                0x3 /* GO TO      */
#define JP                0x4 /* JUMP       */
#define ADD               0x5
#define SUB               0x6
#define MUL               0x7
#define DIV               0x8
#define MOD               0x9

typedef int (*_f)(case_t **);

#define pc                (*get_register(PC)) 
#define op                (*get_register(OP))
#define ep                (*get_register(EP))
#define ap                (*get_register(AP))
#define rs                (*get_register(RS))

#define me                (get_memory())

_f                        get_primitive(int indice);

int                       _me(case_t *a[3]);
int                       _wd(case_t *a[3]);
int                       _ld(case_t *a[3]);
int                       _gt(case_t *a[3]);
int                       _jp(case_t *a[3]);

int                       _add(case_t *a[3]);
int                       _sub(case_t *a[3]);
int                       _mul(case_t *a[3]);
int                       _div(case_t *a[3]);
int                       _mod(case_t *a[3]);

#endif
