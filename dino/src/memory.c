#include "memory.h"

static case_t     memory[SIZE_MEMORY];
static case_t     ts = SIZE_SPACE - 1;
static case_t     newspace = 0;
static case_t     oldspace = SIZE_SPACE;

case_t *
get_memory()
{
  return (memory);
}

case_t
copy(case_t old)
{
  case_t  addr;
  case_t  size;
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
  case_t  temp;
  case_t  scan;
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
allocate(case_t size, case_t *node)
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
