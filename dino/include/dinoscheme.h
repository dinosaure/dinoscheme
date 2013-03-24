#ifndef __DINOSCHEME__
#define __DINOSCHEME__

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#define FAIL  (-1)
#define OK    (0)
#define DONE  (+1)

typedef int32_t t_case;

struct s_dono
{
  t_case  reg[32];
  t_case  *mem;
  int     size;
};
typedef struct s_dono t_dono;

#endif
