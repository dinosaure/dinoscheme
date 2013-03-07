#include "primitive.h"

f_primitive primitives[SIZE_PRIMITIVE] = {
  &p_wd,
  &p_add,
  &p_sub,
  &p_mul,
  &p_div,
  &p_mod,
  &p_end,
  &p_go,
  &p_dp,
  &p_ds,
  &p_fun,
  &p_jmp,
  &p_ld,
  &p_call,
  &p_rtn,
  &p_gt,
  &p_eq,
  &p_df,
  &p_fur,
  &p_tail,
  &p_no,
  &p_cn,
  &p_acc,
  &p_ept,
};

f_primitive
get_primitive(int indice)
{
  if (indice >= SIZE_PRIMITIVE)
    return (NULL);
  else
    return (primitives[indice]);
}

int
p_go(char *instruction)
{
  int32_t size;

  size = get(instruction + pc + 1);

  if (container(size, &op) != OK)
    return (FAIL);

  pc += SIZE_GO;

#ifdef DEBUG
  fprintf(stderr, "go:\t");
  dump_block(get_memory(), op);
#endif

  return (OK);
}

int
p_wd(char *instruction)
{
  int32_t r;
  int32_t w;

  w = get(instruction + pc + 1);

  if (value(w, &r) != OK)
    return (FAIL);

  // push a reference of value
  push(r, op);
  pc += SIZE_WD;

#ifdef DEBUG
  printf("wd:\t%d ", w);
  dump_block(get_memory(), op);
#endif

  return (OK);
}

int
p_add(char *instruction)
{
  int32_t *memory;
  int32_t r;
  int32_t a;
  int32_t b;

  (void) instruction;
  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value(b + a, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_ADD;

#ifdef DEBUG
  printf("add:\t%d + %d = ", b, a);
  dump_block(get_memory(), r);
#endif

  return (OK);
}

int
p_sub(char *instruction)
{
  int32_t r;
  int32_t *memory;
  int32_t a;
  int32_t b;

  (void) instruction;
  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value(b - a, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_SUB;

#ifdef DEBUG
  printf("sub:\t%d - %d = ", b, a);
  dump_block(get_memory(), r);
#endif

  return (OK);
}

int
p_mul(char *instruction)
{
  int32_t r;
  int32_t *memory;
  int32_t a;
  int32_t b;

  (void) instruction;
  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value(b * a, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_MUL;

#ifdef DEBUG
  printf("mul:\t%d * %d = ", b, a);
  dump_block(get_memory(), r);
#endif

  return (OK);
}

int
p_div(char *instruction)
{
  int32_t r;
  int32_t *memory;
  int32_t a;
  int32_t b;

  (void) instruction;
  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value(b / a, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_DIV;

#ifdef DEBUG
  printf("div:\t%d / %d = ", b, a);
  dump_block(get_memory(), r);
#endif

  return (OK);
}

int
p_mod(char *instruction)
{
  int32_t r;
  int32_t *memory;
  int32_t a;
  int32_t b;

  (void) instruction;
  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value(b % a, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_MOD;

#ifdef DEBUG
  printf("mod:\t%d %% %d = ", b, a);
  dump_block(get_memory(), r);
#endif

  return (OK);
}

int
p_end(char *instruction)
{
  (void) instruction;

#ifdef DEBUG
  printf("end\n");
#endif

  return (DONE);
}

int
p_dp(char *instruction)
{
  (void) instruction;

  printf("\n");

  dump(get_memory(), SIZE_SPACE);
  pc += SIZE_DP;

  printf("\n");

  return (OK);
}

int
p_ds(char *instruction)
{
  int32_t c;
  int32_t r;
  int32_t *memory;

  memory = get_memory();

  switch (get(instruction + pc + 1))
    {
      case 1:   c = printf("%c", memory[pop(op) + SLOT_VALUE]);
                break;
      case 2:   c = printf("%d", memory[pop(op) + SLOT_VALUE]);
                break;
      case 3:   c = printf("%s", (memory[pop(op) + SLOT_VALUE] == 1) ? "true" : "false");
                break;
      default:  c = printf("[%d]", memory[pop(op) + SLOT_VALUE]);
                break;
    }

  if (value(c, &r) != OK)
    return (FAIL);

  push(r, op);

  pc += SIZE_DS;

  return (OK);
}

int
p_fun(char *instruction)
{
  int32_t size;
  int32_t closure;
  int32_t *memory;

  size = get(instruction + pc + 1);
  memory = get_memory();

  if (container(3, &closure) != OK)
    return (FAIL);

  // new closure with position of code, size of stack (and environment), and
  // current environment (\x \n x)
  memory[closure + SLOT_LCHILD] += 1;
  memory[closure + memory[closure + SLOT_FCHILD] + 1] = ep;
  memory[closure + memory[closure + SLOT_FCHILD] + 2] = size;
  memory[closure + memory[closure + SLOT_FCHILD] + 3] = pc + SIZE_JMP + SIZE_FUN;

  push(closure, op);
  pc += SIZE_FUN;

#ifdef DEBUG
  printf("fun:\t");
  dump_block(memory, closure);
#endif

  return (OK);
}

int
p_fur(char *instruction)
{
  int32_t size;
  int32_t closure;
  int32_t *memory;
  int32_t env;

  size = get(instruction + pc + 1);
  memory = get_memory();

  if (container(3, &closure) != OK)
    return (FAIL);

  if (environment_extend(ep, 1, &env) != OK)
    return (FAIL);

  // memory[env + memory[env + SLOT_LCHILD]] = closure;
  environment_set(env, 0, closure);

  // new closure with position of code, size of stack (and environment), and
  // current environment (\x \n x)
  memory[closure + SLOT_LCHILD] += 1;
  memory[closure + memory[closure + SLOT_FCHILD] + 1] = env;
  memory[closure + memory[closure + SLOT_FCHILD] + 2] = size;
  memory[closure + memory[closure + SLOT_FCHILD] + 3] = pc + SIZE_JMP + SIZE_FUN;

  push(closure, op);
  pc += SIZE_FUR;

#ifdef DEBUG
  printf("fur:\t");
  dump_block(memory, closure);
  printf("\t");
  dump_block(memory, env);
#endif

  return (OK);
}

int
p_jmp(char *instruction)
{
  int32_t word;

  word = get(instruction + pc + 1);
  pc += SIZE_JMP + word;

#ifdef DEBUG
  printf("jmp:\t%d\n", word);
#endif

  return (OK);
}

int
p_ld(char *instruction)
{
  int32_t word;

  word = get(instruction + pc + 1);
  push(environment_get(ep, word), op);

  pc += SIZE_LD;

#ifdef DEBUG
  printf("ld:\t");
  dump_block(get_memory(), ep);
  printf("\t");
  dump_block(get_memory(), environment_get(ep, word));
#endif

  return (OK);
}

int
p_call(char *instruction)
{
  int32_t closure;
  int32_t addr;
  int32_t size;
  int32_t value;
  int32_t *memory;
  int32_t frame;

  (void) instruction;

  value = pop(op);
  closure = pop(op);

  // get information (closure, position after closure, size of operation stack)
  memory = get_memory();
  addr = memory[closure + memory[closure + SLOT_FCHILD] + 3];
  size = memory[closure + memory[closure + SLOT_FCHILD] + 2];


  // extend environment to new size in ap
  if (environment_extend(memory[closure + memory[closure + SLOT_LCHILD] - 0], 1, &ap) != OK)
    return (FAIL);

  environment_set(ap, 0, value); // add reference of value for ld opcode

  if (container(3, &frame) != OK)
    return (FAIL);

  // new frame with new pc, current operation stack and current environment
  memory[frame + SLOT_LCHILD] += 2;
  memory[frame + memory[frame + SLOT_FCHILD] + 1] = op;
  memory[frame + memory[frame + SLOT_FCHILD] + 2] = ep;
  memory[frame + memory[frame + SLOT_FCHILD] + 3] = pc + SIZE_CALL;

  push(frame, rs);

#ifdef DEBUG
  printf("call:\t");
  dump_block(memory, closure);
  printf("\t");
  dump_block(memory, ap);
  printf("\t");
  dump_block(memory, memory[closure + memory[closure + SLOT_LCHILD] - 0]);
  printf("\t");
  dump_block(memory, frame);
#endif

  // pc to code of closure and ep to new environment
  pc = addr;
  ep = ap;
  ap = -1;

  // new operation stack
  if (container(size, &op) != OK)
    return (FAIL);

  return (OK);
}

int
p_rtn(char *instruction)
{
  int32_t frame;
  int32_t r;
  int32_t *memory;

  memory = get_memory();
  (void) instruction;

  // recovery frame
  frame = pop(rs);

  // back in the old situation (pc, ep)
  pc = memory[frame + memory[frame + SLOT_FCHILD] + 3];
  ep = memory[frame + memory[frame + SLOT_FCHILD] + 2];

  // recovery of the return value of the function
  r = pop(op);

  // back in the old operation stack
  op = memory[frame + memory[frame + SLOT_FCHILD] + 1];

  // push a result in the old operation stack
  push(r, op);

#ifdef DEBUG
  printf("rtn:\t%d ", pc);
  dump_block(memory, r);
#endif

  return (OK);
}

int
p_gt(char *instruction)
{
  int32_t *memory;
  int32_t v;

  memory = get_memory();
  v = memory[pop(op) + SLOT_VALUE];


  if (v == 0)
    pc += SIZE_GT + get(instruction + pc + 1);
  else
    pc += SIZE_GT;

#ifdef DEBUG
  printf("gt\t%d -> %d\n", v, pc);
#endif

  return (OK);
}

int
p_eq(char *instruction)
{
  int32_t a;
  int32_t b;
  int32_t *memory;
  int32_t r;

  (void) instruction;

  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value((a == b) ? 1 : 0, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_EQ;

#ifdef DEBUG
  printf("eq:\t%d == %d\n", a, b);
#endif

  return (OK);
}

int
p_df(char *instruction)
{
  int32_t a;
  int32_t b;
  int32_t *memory;
  int32_t r;

  (void) instruction;

  memory = get_memory();
  a = memory[pop(op) + SLOT_VALUE];
  b = memory[pop(op) + SLOT_VALUE];

  if (value((a != b) ? 1 : 0, &r) != OK)
    return (FAIL);

  push(r, op);
  pc += SIZE_EQ;

#ifdef DEBUG
  printf("df:\t%d != %d\n", a, b);
#endif

  return (OK);
}

int
p_tail(char *instruction)
{
  int32_t closure;
  int32_t addr;
  int32_t size;
  int32_t value;
  int32_t *memory;

  (void) instruction;

  value = pop(op);
  closure = pop(op);

  // get information (closure, position after closure, size of operation stack)
  memory = get_memory();
  addr = memory[closure + memory[closure + SLOT_FCHILD] + 3];
  size = memory[closure + memory[closure + SLOT_FCHILD] + 2];

  if (environment_extend(memory[closure + memory[closure + SLOT_LCHILD] - 0], 1, &ep) != OK)
    return (FAIL);

  environment_set(ep, 0, value); // add reference of value for ld opcode

#ifdef DEBUG
  printf("tail:\t");
  dump_block(memory, closure);
  printf("\t");
  dump_block(memory, ep);
  printf("\t");
  dump_block(memory, memory[closure + memory[closure + SLOT_LCHILD] - 0]);
#endif

  pc = addr;

  if (container(size, &op) != OK)
    return (FAIL);

  return (OK);
}

int
p_no(char *instruction)
{
  (void) instruction;

  pc += SIZE_NO;

  return (OK);
}

int
p_cn(char *instruction)
{
  int32_t size;
  int32_t l;
  int32_t i;
  int32_t e;
  int32_t *memory;

  memory = get_memory();
  size = get(instruction + pc + 1);

  if (container(size, &l) != OK)
    return (FAIL);

  memory[l + SLOT_LCHILD] += size;
  i = size - 1;

  while (i >= 0)
    {
      e = pop(op);
      memory[l + memory[l + SLOT_LCHILD] - i] = e;
      i = i - 1;
    }

  push(l, op);

  pc += SIZE_CN;

#ifdef DEBUG
  printf("cn:\t");
  dump_block(get_memory(), l);
#endif

  return (OK);
}

int
p_acc(char *instruction)
{
  int32_t p;
  int32_t e;
  int32_t *memory;

  memory = get_memory();
  p = get(instruction + pc + 1);
  e = pop(op);

  push(memory[e + memory[e + SLOT_LCHILD] - p], op);

  pc += SIZE_ACC;

#ifdef DEBUG
  printf("acc:\t");
  dump_block(get_memory(), memory[e + memory[e + SLOT_LCHILD] - p]);
#endif

  return (OK);
}

int
p_ept(char *instruction)
{
  int32_t e;
  int32_t s;
  int32_t r;
  int32_t *memory;

  (void) instruction;

  memory = get_memory();
  e = pop(op);
  s = memory[e + SLOT_LCHILD] - memory[e + SLOT_FCHILD];

  if (value((s == 0 ? 1 : 0), &r) != OK)
    return (FAIL);

  push(r, op);

  pc += SIZE_EPT;

#ifdef DEBUG
  printf("ept:\t");
  dump_block(get_memory(), r);
#endif

  return (OK);
}
