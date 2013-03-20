type t =
  | Instr of t list
  | Word of string
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * t
  | List of t * t
  | Sequence of t * t
  | Condition of t * t * t
  | Nill
  | Null
  | Application of t * t
