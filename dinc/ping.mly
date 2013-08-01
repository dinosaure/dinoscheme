%{
  let foldl f a l = List.fold_left f a l
  let foldr f a l = List.fold_right f l a

  let explode s =
    let rec aux acc = function
      | -1 -> acc
      | k -> aux (s.[k] :: acc) (k - 1)
    in aux [] (String.length s - 1)
%}

%start <Ding.t list> main

%token EOF
%token RPA LPA
%token RBR LBR
%token DEFINE
%token APPLY
%token TYPE
%token T_INTEGER
%token T_REAL
%token T_BOOLEAN
%token T_CHARACTER
%token T_VOID
%token T_LIST
%token T_ARROW
%token T_TUPLE
%token <string> Word
%token <int> Integer

%right T_ARROW
%left T_LIST

%%

expression:
  | RPA T_LIST a = expression LPA
  { Type.short_kind "list" [|a|]}
  | RPA T_ARROW a = expression b = expression LPA
  { Type.short_kind "->" [|a; b|] }
  | RPA t = tuple LPA
  { Type.short_kind "*"  (Array.of_list t) }
  | x = leave
  { x }
  | RBR x = instr LBR
  { x }

instr:
  | a = instr T_LIST
  { Type.short_kind "list" [|a|] }
  | a = instr T_ARROW b = instr
  { Type.short_kind "->" [|a; b|] }
  | x = expression
  { x }

tuple:
  | a = expression T_TUPLE b = expression
  { [a; b] }
  | h = expression T_TUPLE t = tuple
  { h :: t }

leave:
  | T_INTEGER
  { Type.short_kind "integer" [||] }
  | T_REAL
  { Type.short_kind "real" [||] }
  | T_BOOLEAN
  { Type.short_kind "boolean" [||] }
  | T_CHARACTER
  { Type.short_kind "character" [||] }
  | T_VOID
  { Type.short_kind "void" [||] }
  | s = Word
  { Type.short_variable s }

core:
  | RPA DEFINE n = Word c = Integer RPA TYPE t = expression LPA LPA r = main
  { ( Ding.Define (n, c, Type.kind_from_short_kind t) ) :: r }
  | RPA DEFINE n = Word c = Integer RPA TYPE t = expression LPA LPA
  { [ Ding.Define (n, c, Type.kind_from_short_kind t) ] }
  | RPA APPLY s = Word f = Word LPA r = main
  { ( Ding.Apply (s, f) ) :: r }
  | RPA APPLY s = Word f = Word LPA
  { [ Ding.Apply (s, f) ] }

main:
  | i = core EOF { i }
