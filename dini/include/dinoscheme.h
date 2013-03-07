#ifndef __DINOSCHEME__
#define __DINOSCHEME__

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>

#define OK    0
#define FAIL  1
#define DONE  2

#define SIZE_STACK      32
#define SIZE_REGISTER   32
#define SIZE_MEMORY     (4096 * 2)
#define SIZE_SPACE      (SIZE_MEMORY / 2)

typedef int32_t case_t;

struct pgrm_s
{
  /*
   * MEMORY HEAP
   *
   */

  case_t  memory[SIZE_MEMORY];
  case_t  newspace;
  case_t  oldspace;
  case_t  ts;

  /*
   * REGISTERS
   *
   */

  case_t  registers[SIZE_REGISTER];

  /*
   * STACK 
   *
   */

  case_t  rs[SIZE_STACK];

  /*
   * CODE
   *
   */

  char    *instruction;
};
typedef struct pgrm_s pgrm_t;

#endif
