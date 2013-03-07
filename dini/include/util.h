#ifndef __UTIL__
#define __UTIL__

#include "dinoscheme.h"

#define ABS(x) ((x < 0) ? (-x) : (x))

int32_t get(char *instruction);
void    dump(int32_t *memory, size_t size);
void    dump_block(int32_t *memory, int position);

#endif
