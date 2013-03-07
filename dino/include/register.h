#ifndef __REGISTER__
#define __REGISTER__

#include "dinoscheme.h"

#define PC            SIZE_REGISTER - 8
#define SP            SIZE_REGISTER - 7
#define MP            SIZE_REGISTER - 6
#define EP            SIZE_REGISTER - 5
#define OP            SIZE_REGISTER - 4
#define AP            SIZE_REGISTER - 3
#define TP            SIZE_REGISTER - 2
#define RS            SIZE_REGISTER - 1

int32_t               *get_register(int indice);

#endif
