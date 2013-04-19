type t =
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
  | Variable of string * int
  | Application of t * t
  | Primitive of string * t list

module Ei: Map.S with type key = string 

val indexing: int -> int Ei.t -> Lambda.t -> t
val eval: Lambda.t -> t
