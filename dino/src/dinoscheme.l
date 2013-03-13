%{

#include "dinoscheme.h"

#define ABS(a)  ((a < 0) ? -a : a)

#define PC    (0)
#define MP    (1)
#define EP    (2)
#define OP    (3)
#define RS    (4)
#define TS    (5)
#define NS    (6)
#define OS    (7)
#define AP    (8)

#define pc    (dono->reg[PC])
#define mp    (dono->reg[MP])
#define ep    (dono->reg[EP])
#define op    (dono->reg[OP])
#define rs    (dono->reg[RS])
#define ts    (dono->reg[TS])
#define ns    (dono->reg[NS])
#define os    (dono->reg[OS])
#define ap    (dono->reg[AP])

#define SIZE_CONTAINER  (4)
#define SIZE_VALUE      (5)
#define SIZE_STACK      (32)
#define SIZE_MEMORY     (2048)

#define SLOT_SIZE       (0)
#define SLOT_FORWARD    (1)
#define SLOT_FCHILD     (2)
#define SLOT_LCHILD     (3)
#define SLOT_VALUE      (4)

#define NFORWARD        (-1)
#define NCHILD          (3)

#define mem             (dono->mem)

#define YY_USER_INIT    t_dono *	dono = get_dono()
#define YY_USER_ACTION  pc = pc + yyleng;
#define ECHO

  static t_dono *	dono = NULL;

  static void     dump(FILE *fd, t_case *ptr, int position);
  static t_dono * get_dono();
  static void     set_dono(t_dono *new);
  static t_case   get(char *instr);
  static t_case   copy(t_dono *dono, t_case old);
  static void     flip(t_dono *dono);
  static int      allocate(t_dono *dono, t_case size, t_case *node);
  static int      container(t_dono *dono, t_case size, t_case *node);
  static int      value(t_dono *dono, t_case value, t_case *node);
  static t_case   environment_get(t_dono *dono, t_case e, t_case v);
  static void     environment_set(t_dono *dono, t_case e, t_case v, t_case d);
  static int      environment_extend(t_dono *dono, t_case e, unsigned int s, t_case *node);
  static void     push(t_dono *dono, t_case value, t_case stack);
  static t_case   pop(t_dono *dono, t_case stack);

%}

%option noyywrap

CODE  [\x00-\xFF]
WD    \x00
ADD   \x01
SUB   \x02
MUL   \x03
DIV   \x04
MOD   \x05
END   \x06
GO    \x07
DP    \x08
DS    \x09
FUN   \x0A
JMP   \x0B
LD    \x0C
CAL   \x0D
RTN   \x0E
GT    \x0F
EQ    \x10
DF    \x11
FUR   \x12
TAIL  \x13
NO    \x14
CN    \x15
ACC   \x16
EPT   \x17

%%

\x00{CODE}{CODE}{CODE}{CODE} {
  t_case    r;
  t_case    w;

  w = get(yytext + 1);

  if (value(dono, w, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "WD\t%d", w);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x01 {
  t_case    r;
  t_case    a;
  t_case    b;

  a = mem[pop(dono, op) + SLOT_VALUE];
  b = mem[pop(dono, op) + SLOT_VALUE];

  if (value(dono, b + a, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "ADD\t%d + %d", b, a);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x02 {
  t_case    r;
  t_case    a;
  t_case    b;

  a = mem[pop(dono, op) + SLOT_VALUE];
  b = mem[pop(dono, op) + SLOT_VALUE];

  if (value(dono, b - a, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "ADD\t%d - %d", b, a);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x03 {
  t_case    r;
  t_case    a;
  t_case    b;

  a = mem[pop(dono, op) + SLOT_VALUE];
  b = mem[pop(dono, op) + SLOT_VALUE];

  if (value(dono, b * a, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "ADD\t%d * %d", b, a);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x04 {
  t_case    r;
  t_case    a;
  t_case    b;

  a = mem[pop(dono, op) + SLOT_VALUE];
  b = mem[pop(dono, op) + SLOT_VALUE];

  if (value(dono, b / a, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "ADD\t%d / %d", b, a);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x05 {
  t_case    r;
  t_case    a;
  t_case    b;

  a = mem[pop(dono, op) + SLOT_VALUE];
  b = mem[pop(dono, op) + SLOT_VALUE];

  if (value(dono, b % a, &r) != OK)
    return (FAIL);

  push(dono, r, op);

#ifdef DEBUG
  fprintf(stderr, "ADD\t%d % %d", b, a);
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x06 {
#ifdef DEBUG
  fprintf(stderr, "END\n");
#endif

  return (DONE);
}

\x07{CODE}{CODE}{CODE}{CODE} {
  if (container(dono, get(yytext + 1), &op))
    return (FAIL);

#ifdef DEBUG
  fprintf(stderr, "BEGIN\t");
  dump(stderr, mem, op);
#endif

  return (OK);
}

\x09{CODE}{CODE}{CODE}{CODE} {
  t_case    c;
  t_case    r;

  switch (get(yytext + 1))
    {
      case 1:   c = printf("%c", mem[pop(dono, op) + SLOT_VALUE]);
                break;
      case 2:   c = printf("%d", mem[pop(dono, op) + SLOT_VALUE]);
                break;
      case 3:   c = printf("%s", (mem[pop(dono, op) + SLOT_VALUE] == 1) ? "true" : "false");
                break;
      default:  c = printf("[%d]", mem[pop(dono, op) + SLOT_VALUE]);
                break;
    }

  if (value(dono, c, &r) != OK)
    return (FAIL);

  push(dono, r, op);

  return (OK);
}

\x0A{CODE}{CODE}{CODE}{CODE} {
  t_case    size;
  t_case    closure;

  size = get(yytext + 1);

  if (container(dono, 3, &closure) != OK)
    return (FAIL);

  mem[closure + SLOT_LCHILD] += 1;
  mem[closure + mem[closure + SLOT_FCHILD] + 1] = ep;
  mem[closure + mem[closure + SLOT_FCHILD] + 2] = size;
  mem[closure + mem[closure + SLOT_FCHILD] + 3] = pc + 5;

  push(dono, closure, op);

#ifdef DEBUG
  fprintf(stderr, "FUN\t");
  dump(stderr, mem, closure);
#endif

  return (OK);
}

\x0B{CODE}{CODE}{CODE}{CODE} {
  t_case  wd;

  wd = get(yytext + 1);
  pc = pc + wd;
  fseek(yyin, pc, SEEK_SET);
  yyrestart(yyin);

#ifdef DEBUG
  fprintf(stderr, "JMP\t%d\n", wd);
#endif

  return (OK);
}

\x0C{CODE}{CODE}{CODE}{CODE} {
  t_case    word;
  t_case    data;

  word = get(yytext + 1);
  data = environment_get(dono, ep, word);
  push(dono, data, op);

#ifdef DEBUG
  fprintf(stderr, "LD\t");
  dump(stderr, mem, ep);
  fprintf(stderr, "\t");
  dump(stderr, mem, environment_get(dono, ep, word));
#endif

  return (OK);
}

\x0D {
  t_case    closure;
  t_case    addr;
  t_case    size;
  t_case    value;
  t_case    frame;

  closure = mem[op + mem[op + SLOT_LCHILD] - 1];
  addr = mem[closure + mem[closure + SLOT_FCHILD] + 3];
  size = mem[closure + mem[closure + SLOT_FCHILD] + 2];

  if (environment_extend(dono, mem[closure + mem[closure + SLOT_LCHILD] - 0], 1, &ap) != OK)
    return (FAIL);

  value = pop(dono, op);
  (void) pop(dono, op);
  environment_set(dono, ap, 0, value);

  if (container(dono, 3, &frame) != OK)
    return (FAIL);

  mem[frame + SLOT_LCHILD] += 2;
  mem[frame + mem[frame + SLOT_FCHILD] + 1] = op;
  mem[frame + mem[frame + SLOT_FCHILD] + 2] = ep;
  mem[frame + mem[frame + SLOT_FCHILD] + 3] = pc;

  push(dono, frame, rs);

#ifdef DEBUG
  fprintf(stderr, "CALL\t");
  dump(stderr, mem, closure);
  fprintf(stderr, "\t");
  dump(stderr, mem, ap);
  fprintf(stderr, "\t");
  dump(stderr, mem, mem[closure + mem[closure + SLOT_LCHILD] - 0]);
  fprintf(stderr, "\t");
  dump(stderr, mem, frame);
#endif

  fseek(yyin, addr, SEEK_SET);
  ep = ap;
  ap = -1;
  pc = addr;

  if (container(dono, size, &op) != OK)
    return (FAIL);

  yyrestart(yyin);

  return (OK);
}

\x0E {
  t_case    frame;
  t_case    ret;

  frame = pop(dono, rs);

  fseek(yyin, mem[frame + mem[frame + SLOT_FCHILD] + 3], SEEK_SET);
  pc = mem[frame + mem[frame + SLOT_FCHILD] + 3];
  ep = mem[frame + mem[frame + SLOT_FCHILD] + 2];

  ret = pop(dono, op);

  op = mem[frame + mem[frame + SLOT_FCHILD] + 1];

  push(dono, ret, op);
  yyrestart(yyin);

#ifdef DEBUG
  fprintf(stderr, "RTN\t%d ", pc);
  dump(stderr, mem, ret);
#endif

  return (OK);
}

\x0F {
  t_case    v;

  v = mem[pop(dono, op) + SLOT_VALUE];

  if (v == 0)
    fseek(yyin, pc + get(yytext + 1) + 5, SEEK_SET);
  else
    fseek(yyin, pc + 5, SEEK_SET);

#ifdef DEBUG
  fprintf(stderr, "GT\t%d -> %d\n", v, (v == 0) ? pc + get(yytext + 1) + 5 : pc + 5);
#endif

  yyrestart(yyin);
}

\x13 {
  t_case  closure;
  t_case  addr;
  t_case  size;
  t_case  value;

  value = pop(dono, op);
  closure = pop(dono, op);
  addr = mem[closure + mem[closure + SLOT_FCHILD] + 3];
  size = mem[closure + mem[closure + SLOT_FCHILD] + 2];

  if (environment_extend(dono, mem[closure + mem[closure + SLOT_LCHILD] - 0], 1, &ep) != OK)
    return (FAIL);

  environment_set(dono, ep, 0, value);
  fseek(yyin, addr, SEEK_SET);
  pc = addr;

  if (container(dono, size, &op) != OK)
    return (FAIL);

#ifdef DEBUG
  fprintf(stderr, "TAIL\t");
  dump(stderr, mem, closure);
  fprintf(stderr, "\t");
  dump(stderr, mem, ep);
  fprintf(stderr, "\t");
  dump(stderr, mem, mem[closure + mem[closure + SLOT_LCHILD] - 0]);
#endif

  yyrestart(yyin);

  return (OK);
}

%%

void
dump(FILE *fd, t_case *ptr, int position)
{
  int size;
  int i;

  size = ptr[position];
  i = 0;

  fprintf(fd, "[ ");

  while (i < size)
    {
      fprintf(fd, "%04x ", ABS(mem[position + i]));
      i = i + 1;
    }

  fprintf(fd, "]\n");
}

static t_dono *
get_dono()
{ return (dono); }

static void
set_dono(t_dono *new)
{ dono = new; }

static t_case
get(char *instr)
{
  t_case  r;
  int     i;
  int     p;

  r = 0;
  i = 0;
  p = 1;

  if ((unsigned char) instr[i] > 127)
    {
      instr[i] = instr[i] - 128;
      p = -1;
    }

  r = r + ((unsigned int) instr[i] << (8 * (4 - i - 1)));
  i = i + 1;

  while (i < 4)
    {
      r = r + ((unsigned int) instr[i] << (8 * (4 - i - 1)));
      i = i + 1;
  }

  return (r * p);
}

static t_case
copy(t_dono *dono, t_case old)
{
  t_case  addr;
  t_case  size;
  int     i;

  if (mem[old + SLOT_FORWARD] >= ns
      && mem[old + SLOT_FORWARD] <= ts)
    return (mem[old + SLOT_FORWARD]);
  else
    {
      addr = mp;
      size = mem[old + SLOT_SIZE];
      i = 0;

      while (i < size)
        {
          mem[addr + i] = mem[old + i];
          i = i + 1;
        }

      mem[old + SLOT_FORWARD] = addr;
      mp = mp + size;

      return (addr);
    }
}

static void
flip(t_dono *dono)
{
  t_case  tmp;
  t_case  scn;
  int     i;

  tmp = os;
  os = ns;
  ns = tmp;
  ts = ns + (dono->size / 2) - 1;

  scn = ns;
  mp = ns;

  ep = copy(dono, ep);
  op = copy(dono, op);
  rs = copy(dono, rs);

  if (ap != -1)
    ap = copy(dono, ap);

  while (scn < mp)
    {
      tmp = mem[scn + SLOT_SIZE];
      i = mem[scn + SLOT_LCHILD];

      while (i > mem[scn + SLOT_FCHILD])
        {
          mem[scn + i] = copy(dono, mem[scn + i]);
          i = i - 1;
        }

      scn = scn + tmp;
    }
}

static int
allocate(t_dono *dono, t_case size, t_case *node)
{
  int i;

  if (size + mp > ts)
    flip(dono);

  if (size + mp > ts)
    {
      fprintf(stderr, "Memory fail");
      return (FAIL);
    }

  (*node) = mp;
  i = 0;

  while (i < size)
    {
      mem[(*node) + i] = (-1);
      i = i + 1;
    }

  mp = mp + size;

  return (OK);
}

static int
container(t_dono *dono, t_case size, t_case *node)
{
  if (allocate(dono, SIZE_CONTAINER + size, node) != OK)
    return (FAIL);

  mem[(*node) + SLOT_SIZE] = SIZE_CONTAINER + size;
  mem[(*node) + SLOT_FORWARD] = NFORWARD;
  mem[(*node) + SLOT_FCHILD] = NCHILD;
  mem[(*node) + SLOT_LCHILD] = NCHILD;

  return (OK);
}

static int
value(t_dono *dono, t_case value, t_case *node)
{
  if (allocate(dono, SIZE_VALUE, node) != OK)
    return (FAIL);

  mem[(*node) + SLOT_SIZE] = SIZE_VALUE;
  mem[(*node) + SLOT_FORWARD] = NFORWARD;
  mem[(*node) + SLOT_FCHILD] = NCHILD;
  mem[(*node) + SLOT_LCHILD] = NCHILD;
  mem[(*node) + SLOT_VALUE] = value;

  return (OK);
}

static t_case
environment_get(t_dono *dono, t_case e, t_case v)
{
  if (v < 0 || v > mem[e + SLOT_LCHILD] - mem[e + SLOT_FCHILD])
    fprintf(stderr, "Variable out of range\n");

  return (mem[e + mem[e + SLOT_LCHILD] - v]);
}

static void
environment_set(t_dono *dono, t_case e, t_case v, t_case d)
{
  if (v < 0 || v > mem[e + SLOT_LCHILD] - mem[e + SLOT_FCHILD])
    fprintf(stderr, "Variable out of range\n");

  mem[e + mem[e + SLOT_LCHILD] - v] = d;
}

static int
environment_extend(t_dono *dono, t_case e, unsigned int s, t_case *node)
{
  t_case  old;
  t_case  i;

  old = mem[e + SLOT_SIZE] - SIZE_CONTAINER;

  if (container(dono, old + s, node) != OK)
    return (FAIL);

  if (mem[e + SLOT_FORWARD] != -1)
    e = mem[e + SLOT_FORWARD];

  i = mem[e + SLOT_FCHILD];

  while (i < mem[e + SLOT_LCHILD])
    {
      mem[(*node) + i + 1] = mem[e + i + 1];
      i = i + 1;
    }

  mem[(*node) + SLOT_LCHILD] += old + s;

  return (OK);
}

static void
push(t_dono *dono, t_case value, t_case stack)
{
  t_case  a;
  t_case  b;

  mem[stack + SLOT_LCHILD] = mem[stack + SLOT_LCHILD] + 1;
  a = mem[stack + SLOT_FCHILD];
  b = mem[stack + SLOT_LCHILD];

  if (b - a > mem[stack + SLOT_SIZE] - SIZE_CONTAINER)
    fprintf(stderr, "Push out of range\n");

  mem[stack + mem[stack + SLOT_LCHILD]] = value;
}

static t_case
pop(t_dono *dono, t_case stack)
{
  t_case  r;
  t_case  a;
  t_case  b;

  a = mem[stack + SLOT_FCHILD];
  b = mem[stack + SLOT_LCHILD];

  if (b - a <= 0)
    fprintf(stderr, "Pop out of range\n");

  r = mem[stack + mem[stack + SLOT_LCHILD]];
  mem[stack + SLOT_LCHILD] = mem[stack + SLOT_LCHILD] - 1;

  return (r);
}

int
run(FILE *fd)
{
  int       err;
  t_dono    work;
  t_dono *  dono;

  dono = &work;
  yyin = fd;
  err = OK;

  memset(dono->reg, -1, sizeof(t_case));
  mem = malloc(SIZE_MEMORY * sizeof(t_case));
  set_dono(dono);

  if (mem == NULL)
    return (FAIL);

  ts = SIZE_MEMORY - 1;
  ap = (-1);
  ns = 0;
  mp = 0;
  pc = 0;
  os = SIZE_MEMORY;

  if (container(dono, 0, &ep) != OK)
    return (FAIL);
  if (container(dono, SIZE_STACK, &rs) != OK)
    return (FAIL);

  while ((err = yylex()) == OK);

  free(mem);
  yylex_destroy();

  return (err);
}

int
main(int ac, char **av)
{
  FILE *  fd;

  if (ac == 2 && (fd = fopen(av[1], "r")) != NULL)
    {
      run(fd);
      fclose(fd);
    }

  return (0);
}
