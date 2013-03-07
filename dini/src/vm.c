#include "vm.h"

int
launch(char *instruction)
{
  int     err;
  int32_t *memory;

  err = OK;
  memory = get_memory();

  if (container(0, &ep) != OK)
    return (FAIL);

  if (container(SIZE_STACK, &rs) != OK)
    return (FAIL);

  if (instruction == NULL)
    {
      fprintf(stderr, "No code\n");
      return (1);
    }

  while (err == OK)
    {
      if (instruction[pc] > SIZE_PRIMITIVE)
        err = FAIL;
      else
        err = (*get_primitive(instruction[pc]))(instruction);
    }

  return (err);
}
