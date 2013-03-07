#include "memory.h"

static int32_t     memory[SIZE_MEMORY];
static int32_t     ts = SIZE_SPACE - 1;
static int32_t     newspace = 0;
static int32_t     oldspace = SIZE_SPACE;

int32_t *
get_memory()
{
  return (memory);
}

int
container(int32_t size, int32_t *node)
{
  int32_t *memory;

  memory = get_memory();

  if (allocate(SIZE_CONTAINER + size, node) != OK)
    return (FAIL);

  memory[(*node) + SLOT_SIZE] = SIZE_CONTAINER + size;
  memory[(*node) + SLOT_FORWARD] = NFORWARD;
  memory[(*node) + SLOT_FCHILD] = NCHILD;
  memory[(*node) + SLOT_LCHILD] = NCHILD;

  return (OK);
}

int
value(int32_t value, int32_t *node)
{
  int32_t *memory;

  memory = get_memory();

  if (allocate(SIZE_VALUE, node) != OK)
    return (FAIL);

  memory[(*node) + SLOT_SIZE] = SIZE_VALUE;
  memory[(*node) + SLOT_FORWARD] = NFORWARD;
  memory[(*node) + SLOT_FCHILD] = NCHILD;
  memory[(*node) + SLOT_LCHILD] = NCHILD;
  memory[(*node) + SLOT_VALUE] = value;

  return (OK);
}

int32_t
copy(int32_t old)
{
  int32_t addr;
  int32_t size;
  int     i;

  if (memory[old + SLOT_FORWARD] >= newspace && memory[old + SLOT_FORWARD] <= ts)
    return (memory[old + SLOT_FORWARD]);
  else
    {
      addr = mp;
      size = memory[old + SLOT_SIZE];
      i = 0;

      while (i < size)
        {
          memory[addr + i] = memory[old + i];
          i = i + 1;
        }

      memory[old + SLOT_FORWARD] = addr;
      mp = mp + size;

      return (addr);
    }
}

void
flip()
{
  int32_t temp;
  int32_t scan;
  int     i;

  temp = oldspace;
  oldspace = newspace;
  newspace = temp;
  ts = newspace + SIZE_SPACE - 1;

  scan = newspace;
  mp = newspace;

  rs = copy(rs);
  ep = copy(ep);
  op = copy(op);

  i = 0;

#ifdef DEBUG
  printf("gc:\tflip\n");
#endif

  if (ap != -1)
    ap = copy(ap);

  while (scan < mp)
    {
      temp = memory[scan + SLOT_SIZE];
      i = memory[scan + SLOT_LCHILD];

      while (i > memory[scan + SLOT_FCHILD])
        {
          memory[scan + i] = copy(memory[scan + i]);
          i = i - 1;
        }

      scan = scan + temp;
    }
}

int
allocate(int32_t size, int32_t *node)
{
  int i;

  i = 0;

  if (size + mp > ts)
    flip();

  if (size + mp > ts)
    return (FAIL);

  (*node) = mp;

  while (i < size)
    {
      memory[ *node + i ] = -1;
      i = i + 1;
    }

  mp += size;

  return (OK);
}
