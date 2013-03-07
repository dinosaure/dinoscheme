#include "primitive.h"

_f
primitives[SIZE_PRIMITIVE] = {
  &_me,
  &_wd,
  &_ld,
  &_gt,
  &_jp,
  &_add,
  &_sub,
  &_mul,
  &_div,
  &_mod,
};

_f
get_primitive(int indice)
{
  if (indice >= SIZE_PRIMITIVE)
    {
      fprintf(stderr, "index out of range (%d primitive)\n", indice);
      exit(EXIT_FAILURE);
    }
  else
    return (primitives[indice]);
}

int
_me(case_t *a[3]) { return (allocate((*a[1]), a[0])); }

int
_wd(case_t *a[3])
{
  me[(*a[0]) + (*a[1])] = (*a[2]);
  return (OK);
}

int
_ld(case_t *a[3])
{
  (*a[0]) = me[(*a[1]) + (*a[2])];
  return (OK);
}

int
_gt(case_t *a[3])
{
  if ((*a[0]) == 0)
    pc = (*a[1]) + (*a[2]);

  return (OK);
}

int
_jp(case_t *a[3])
{
  pc = (*a[0]) + (*a[1]);
  return (OK);
}

int
_add(case_t *a[3])
{
  (*a[0]) = (*a[1]) + (*a[2]);
  return (OK);
}

int
_sub(case_t *a[3])
{
  (*a[0]) = (*a[1]) - (*a[2]);
  return (OK);
}

int
_mul(case_t *a[3])
{
  (*a[0]) = (*a[1]) * (*a[2]);
  return (OK);
}

int
_div(case_t *a[3])
{
  (*a[0]) = (*a[1]) / (*a[2]);
  return (OK);
}

int
_mod(case_t *a[3])
{
  (*a[0]) = (*a[1]) % (*a[2]);
  return (OK);
}
