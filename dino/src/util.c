#include "util.h"

case_t
get_position(char *instruction)
{
  case_t  r;
  int     i;
  int     p;

  r = 0;
  i = 0;
  p = 1;

  if ((unsigned char) instruction[i] > 127)
    {
      instruction[i] = instruction[i] - 128;
      p = -1;
    }

  r += ((unsigned char) instruction[i] << (8 * (4 - i - 1)));
  i = i + 1;

  while (i < 4)
    {
      r += ((unsigned char) instruction[i] << (8 * (4 - i - 1)));
      i = i + 1;
    }

  return (r * p);
}

void
dump(int32_t *memory, size_t size)
{
  unsigned int  i;
  unsigned int  s;

  i = 0;
  s = 0;

  while (i < size)
    {
      if (s == 0 && memory[i] != 0)
        {
          printf("[");
          s = memory[i];
        }
      else
        printf(" ");

      printf("%04x", ABS(memory[i]));

      if ((s - 1) == 0)
        printf("]%s", ((i + 1) % 16 == 0) ? "\n" : " ");
      else
        printf("%s", ((i + 1) % 16 == 0) ? "\n" : "  ");

      s = s - 1;
      i = i + 1;
    }

  if ((i + 1) % 16 == 0)
    printf("\n");
}

void
dump_block(int32_t *memory, int position)
{
  int size;
  int i;

  size = memory[position];
  i = 0;

  printf("[ ");

  while (i < size)
    {
      printf("%04x ", ABS(memory[position + i]));
      i = i + 1;
    }

  printf("]\n");
}
