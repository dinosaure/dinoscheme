#include "environment.h"

int32_t
environment_get(int32_t e, int32_t v)
{
  int32_t *memory;

  memory = get_memory();

  if (v < 0 || v > memory[e + SLOT_LCHILD] - memory[e + SLOT_FCHILD])
    fprintf(stderr, "Variable out of range\n");

  return (memory[e + memory[e + SLOT_LCHILD] - v]);
}

void
environment_set(int32_t e, int32_t v, int32_t d)
{
  int32_t *memory;

  memory = get_memory();

  if (v < 0 || v > memory[e + SLOT_LCHILD] - memory[e + SLOT_FCHILD])
    fprintf(stderr, "Variable out of range\n");

  memory[e + memory[e + SLOT_LCHILD] - v] = d;
}

int
environment_extend(int32_t e, int s, int32_t *node)
{
  int32_t old;
  int32_t i;
  int32_t *memory;

  memory = get_memory();
  old = memory[e + SLOT_SIZE] - SIZE_CONTAINER;

  if (container(old + s, node) != OK)
    return (FAIL);

  if (memory[e + SLOT_FORWARD] != -1)
    e = memory[e + SLOT_FORWARD];

  i = memory[e + SLOT_FCHILD];

  while (i < memory[e + SLOT_LCHILD])
    {
      memory[(*node) + i + 1] = memory[e + i + 1];
      i = i + 1;
    }

  memory[(*node) + SLOT_LCHILD] += old + s;

  return (OK);
}
