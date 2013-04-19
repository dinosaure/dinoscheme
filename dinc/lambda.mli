module El: Set.S with type elt = string

type t =
  | Word of string
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * t * string option
  | List of t * t
  | Sequence of t * t
  | Condition of t * t * t
  | Nill
  | Null
  | Tuple of t list
  | Application of t * t
  | Primitive of string * t list

val eval: El.t -> Ast.t -> t
