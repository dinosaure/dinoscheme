#include "register.h"

static int32_t  registers[SIZE_REGISTER] = { NAN };

int32_t *
get_register(int indice)
{
  if (indice >= SIZE_REGISTER)
    {
      fprintf(stderr, "index out of range (%d register)\n", indice);
      exit(EXIT_FAILURE);
    }
  else
    return (&registers[indice]);
}
