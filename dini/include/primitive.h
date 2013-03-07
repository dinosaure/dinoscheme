#ifndef __PRIMITIVE__
#define __PRIMITIVE__

#include "dinoscheme.h"
#include "register.h"
#include "stack.h"
#include "memory.h"
#include "environment.h"
#include "util.h"

#define SIZE_PRIMITIVE  24

#define WD              0
#define ADD             1
#define SUB             2
#define MUL             3
#define DIV             4
#define MOD             5
#define END             6
#define GO              7
#define DP              8
#define DS              9
#define FUN             10
#define JMP             11
#define LD              12
#define CALL            13
#define RTN             14
#define GT              15
#define EQ              16
#define DF              17
#define FUR             18
#define TAIL            19
#define NO              20
#define CN              21
#define ACC             22
#define EPT             23

#define SIZE_WD         5
#define SIZE_ADD        1
#define SIZE_SUB        1
#define SIZE_MUL        1
#define SIZE_DIV        1
#define SIZE_MOD        1
#define SIZE_END        1
#define SIZE_GO         5
#define SIZE_DP         1
#define SIZE_DS         5
#define SIZE_FUN        5
#define SIZE_JMP        5
#define SIZE_LD         5
#define SIZE_CALL       1
#define SIZE_RTN        1
#define SIZE_GT         5
#define SIZE_EQ         1
#define SIZE_DF         1
#define SIZE_FUR        5
#define SIZE_TAIL       1
#define SIZE_NO         1 /* ONLY SHIT */
#define SIZE_CN         5
#define SIZE_ACC        5
#define SIZE_EPT        1

#define pc              (*get_register(PC)) 
#define op              (*get_register(OP))
#define ep              (*get_register(EP))
#define ap              (*get_register(AP))
#define rs              (*get_register(RS))

typedef int             (*f_primitive)(char *);

f_primitive             get_primitive(int indice);

int                     p_wd      (char *instruction);
int                     p_add     (char *instruction);
int                     p_sub     (char *instruction);
int                     p_mul     (char *instruction);
int                     p_div     (char *instruction);
int                     p_mod     (char *instruction);
int                     p_end     (char *instruction);
int                     p_go      (char *instruction);
int                     p_dp      (char *instruction);
int                     p_ds      (char *instruction);
int                     p_fun     (char *instruction);
int                     p_jmp     (char *instruction);
int                     p_ld      (char *instruction);
int                     p_call    (char *instruction);
int                     p_rtn     (char *instruction);
int                     p_gt      (char *instruction);
int                     p_eq      (char *instruction);
int                     p_df      (char *instruction);
int                     p_fur     (char *instruction);
int                     p_tail    (char *instruction);
int                     p_no      (char *instruction);
int                     p_cn      (char *instruction);
int                     p_acc     (char *instruction);
int                     p_ept     (char *instruction);

#endif
