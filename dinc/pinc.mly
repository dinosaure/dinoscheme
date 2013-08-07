%{

%}

%start <Ast.t> main

%token EOF
%token RPA LPA
%token RBR LBR
%token IF
%token LET
%token DEFINE
%token LAMBDA
%token LIST
%token NILL
%token BEGIN
%token DOT
%token COMMA
%token <string> Word
%token <string> String
%token <char> Character
%token <int> Integer
%token <float> Real
%token <bool> Boolean

%left Word

%%

expression:
  | RPA LAMBDA a = delimited(RPA, Word+, LPA) c = expression LPA
  { Util.foldr (fun x -> fun c -> Ast.Lambda (x, c)) c a }

  | RPA LIST l = expression* LPA 
  { Util.foldr (fun x -> fun y -> Ast.List (x, y)) Ast.Nill l }

  | RPA LET RPA n = Word c = expression LPA r = expression LPA
  { Ast.Application (Ast.Lambda (n, r), c) }

  | RPA IF i = expression a = expression b = expression LPA
  { Ast.Condition (i, a, b) }

  | RPA BEGIN a = expression l = expression + LPA
  { Util.foldl (fun x -> fun y -> Ast.Sequence (x, y)) a l }

  | RPA DOT x = expression r = expression LPA
  { Ast.List (x, r) }

  | RPA t = tuple LPA
  { Ast.Tuple t }

  | l = delimited(RPA, expression+, LPA) 
  { Ast.Instr l }

  | RBR x = instr LBR
  { x }

  | x = leave
  { x }

tuple:
  | a = expression COMMA b = expression
  { [a; b] }

  | h = expression COMMA t = tuple
  { h :: t }

leave:
  | w = Word
  { Ast.Word w }

  | s = String
  { Util.foldr (fun x y -> Ast.List (Ast.Character x, y)) Ast.Nill (Util.explode s) }

  | c = Character
  { Ast.Character c }

  | i = Integer
  { Ast.Integer i }

  | r = Real
  { Ast.Real r }

  | b = Boolean
  { Ast.Boolean b }

  | RPA LPA 
  { Ast.Null }

  | NILL
  { Ast.Nill }

instr: 
  | a = instr o = Word b = instr
  { Ast.Instr [Ast.Word o; a; b] }

  | x = expression
  { x }

define: 
  | RPA DEFINE n = Word c = expression LPA r = main
  { Ast.Application (Ast.Lambda (n, r), c) }

  | RPA DEFINE n = Word c = expression LPA
  { Ast.Application (Ast.Lambda (n, Ast.Null), c) }

main:
  | i = define EOF
  { i }

  | i = expression EOF
  { i }

  | a = expression b = main EOF
  { Ast.Sequence (a, b) }
