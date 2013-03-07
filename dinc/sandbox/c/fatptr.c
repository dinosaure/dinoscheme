#include <stdio.h>
#include <stdlib.h>

struct _e {
    int   s;
    int * a;
};
typedef struct _e _e;

struct _c {
    int (* c)(_e *);
    struct _e * e;
};
typedef struct _c _c;

int
f(_e * env)
{
  return (env->a[1]);
}

int
k(_e * env)
{
  _e * new = (struct _e *)malloc(sizeof(_e));
  new->s = env->s + 1;
  new->a = (int *)malloc(sizeof(int) * new->s);

  new->a[0] = 6;
  new->a[1] = env->a[0];

  _c * clo = (struct _c *)malloc(sizeof(_c));
  clo->e = new;
  clo->c = f;

  return ((int) clo);
}

int main()
{
  _e * env = (struct _e *)malloc(sizeof(_e));
  env->s = 1;
  env->a = (int *)malloc(sizeof(int) * env->s);

  env->a[0] = 5;

  _c * clo = (_c *)k(env);
  printf("%d\n", clo->c(clo->e));

  return (0);
}
