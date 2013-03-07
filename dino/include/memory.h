#ifndef __MEMORY__
#define __MEMORY__

#include "dinoscheme.h"
#include "register.h"
#include "util.h"

#define SIZE_VALUE        5
#define SIZE_CONTAINER    4

#define SLOT_SIZE         0
#define SLOT_FORWARD      1
#define SLOT_FCHILD       2
#define SLOT_LCHILD       3
#define SLOT_VALUE        4

#define NFORWARD          NO
#define NCHILD            3

#define mp                (*get_register(MP))
#define ep                (*get_register(EP))
#define op                (*get_register(OP))
#define tp                (*get_register(TP))
#define ap                (*get_register(AP))
#define rs                (*get_register(RS))

case_t                    *get_memory();
int                       allocate(case_t size, case_t *node);

#endif
