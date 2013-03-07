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
#define NAN   -1

#define SIZE_REGISTER   32
#define SIZE_STACK      32
#define SIZE_MEMORY     4096
#define SIZE_SPACE      (SIZE_MEMORY / 2)

typedef int32_t case_t;

#endif
