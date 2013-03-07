#ifndef __VM__
#define __VM__

#include "dinoscheme.h"
#include "register.h"
#include "memory.h"
#include "primitive.h"

#define pc  (*get_register(PC))
#define ep  (*get_register(EP))
#define rs  (*get_register(RS))

unsigned int  parse(char *instruction, case_t *arg[3]);
int           launch(char *instruction);

#endif
