#include "dinoscheme.h"
#include "vm.h"

int
main(int ac, char **av)
{
  FILE    *fd;
  size_t  size;
  char    *instruction;

  if (ac != 2 || (fd = fopen(av[1], "rb")) == NULL)
    {
      fprintf(stderr, "interpreter file.dono\n");
      return (1);
    }

  fseek(fd, 0, SEEK_END);
  size = ftell(fd);
  instruction = (char *) malloc(size + 1);
  fseek(fd, 0, SEEK_SET);

  if (instruction == NULL)
    {
      fprintf(stderr, "error in malloc\n");
      return (1);
    }

  fread(instruction, size, 1, fd);
  fclose(fd);

  launch(instruction);
  free(instruction);

  return (0);
}
