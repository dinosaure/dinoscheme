#ifndef __ENVIRONMENT__
#define __ENVIRONMENT__

#include "dinoscheme.h"
#include "memory.h"
#include "util.h"

int32_t environment_get(int32_t e, int32_t v);
void    environment_set(int32_t e, int32_t v, int32_t d);
int     environment_extend(int32_t e, int s, int32_t *node);

#endif
