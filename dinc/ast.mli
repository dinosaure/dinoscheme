type expression =
  | Instr of expression list
  | Word of string
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * expression * string option
  | List of expression * expression
  | Sequence of expression * expression
  | Condition of expression * expression * expression
  | Nill
  | Null
  | Variable of string * int
  | Application of expression * expression
  | Primitive of string * expression list

val string_of_ast: expression -> string
