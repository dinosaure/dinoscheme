#include "stack.h"

void
push(int32_t value, int32_t stack)
{
  int32_t *memory;
  int32_t a;
  int32_t b;

  memory = get_memory();
  memory[stack + SLOT_LCHILD] += 1;
  a = memory[stack + SLOT_FCHILD];
  b = memory[stack + SLOT_LCHILD];

  if (b - a > memory[stack + SLOT_SIZE] - SIZE_CONTAINER)
    fprintf(stderr, "Push out of range\n");

  memory[stack + memory[stack + SLOT_LCHILD]] = value;
}

int32_t
pop(int32_t stack)
{
  int32_t *memory;
  int32_t r;
  int32_t a;
  int32_t b;

  memory = get_memory();
  a = memory[stack + SLOT_FCHILD];
  b = memory[stack + SLOT_LCHILD];

  if (b - a <= 0)
    fprintf(stderr, "Pop out of range\n");

  r = memory[stack + memory[stack + SLOT_LCHILD]];
  memory[stack + SLOT_LCHILD] -= 1;

  return (r);
}
