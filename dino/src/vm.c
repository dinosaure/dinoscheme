#include "vm.h"

int
get(char *instruction, char type, case_t *data)
{
  if (type)
    {
      data = get_register((unsigned char) instruction[0]);
      return (1);
    }
  else
    {
      (*data) = get_position(instruction);
      return (4);
    }
}

void
chartobin(unsigned char t)
{
  unsigned int i;

  i = 0;

  while (i < sizeof(unsigned char))
    {
      printf("%c", (t & (1 << i)) ? '1' : '0');
      i = i + 1;
    }

  printf("\n");
}

unsigned int
parse(char *instruction, case_t *arg[3])
{
  unsigned int  opcode;
  static case_t tmp[3] = { NAN };
  int           i;
  int           j;

  opcode = (unsigned char) (instruction[0] >> 4);
  i = 0;
  j = 1;

  while (i < 3)
    {
      if (((unsigned char) instruction[0]) & (1 << i))
        {
          arg[i] = get_register((unsigned char) (instruction + j)[0]);
          j = j + 1;
        }
      else
        {
          tmp[i] = get_position(instruction + j);
          arg[i] = &tmp[i];
          j = j + 4;
        }

      i = i + 1;
    }

  pc = pc + j;

  return (opcode);
}

int
launch(char *instruction)
{
  int     err;
  case_t  *arg[3];
  int     opc;

  err = OK;

  if (instruction == NULL)
    {
      fprintf(stderr, "no instruction (file.dono)\n");
      exit(EXIT_FAILURE);
    }

  pc = 0;

  opc = parse(instruction + pc, arg);
  err = (*get_primitive(opc))(arg);
  opc = parse(instruction + pc, arg);
  err = (*get_primitive(opc))(arg);
  opc = parse(instruction + pc, arg);
  err = (*get_primitive(opc))(arg);

  // while (err == OK)
  //  err = (*get_primitive(instruction[pc]))(arg);

  /* _cn %ep 4

  arg[0] = &ep;
  one = 4;
  arg[1] = &one;
  _me(arg);

  arg[0] = &ep;
  one = 0;
  two = 4;
  arg[1] = &one;
  arg[2] = &two;
  _wd(arg);

  arg[0] = &ep;
  one = 1;
  two = NO;
  arg[1] = &one;
  arg[2] = &two;
  _wd(arg);

  arg[0] = &ep;
  one = 2;
  two = 3;
  arg[1] = &one;
  arg[2] = &two;
  _wd(arg);

  arg[0] = &ep;
  one = 3;
  two = 3;
  arg[1] = &one;
  arg[2] = &two;
  _wd(arg);

  */

  dump(get_memory(), SIZE_SPACE);

  return (err);
}
