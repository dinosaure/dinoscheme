#ifndef __REGISTER__
#define __REGISTER__

#include "dinoscheme.h"

#define PC            0
#define SP            1
#define MP            2
#define EP            3
#define OP            4
#define AP            5
#define TP            6
#define RS            7

int32_t               *get_register(int indice);

#endif
