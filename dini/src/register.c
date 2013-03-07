#include "register.h"

static int32_t  registers[SIZE_REGISTER] = { 0 };

int32_t *
get_register(int indice)
{
  if (indice >= SIZE_REGISTER)
    return (NULL);
  else
    return (&registers[indice]);
}
