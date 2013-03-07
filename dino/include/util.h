#ifndef __UTIL__
#define __UTIL__

#include "dinoscheme.h"

#define ABS(x) ((x < 0) ? (-x) : (x))

case_t  get_position(char *instruction);
void    dump(case_t *memory, size_t size);

#endif
