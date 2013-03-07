#ifndef __STACK__
#define __STACK__

#include "dinoscheme.h"
#include "register.h"
#include "memory.h"

void                            push(int32_t value, int32_t stack);
int32_t                         pop(int32_t stack);

#endif
