module Sc: Set.S with type elt = string
module Ec: Map.S with type key = string

type t =
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool
  | Nill
  | Null
  | Application of t * t
  | Closure of lambda * environment
  | Get of string * int
  | Variable of string
  | Condition of t * t * t
  | List of t * t
  | Sequence of t * t
  | Primitive of string * t list
and lambda = string * string * t * string option
and environment = (int * string) list

val free: Lambda.t -> Sc.t
val eval: (string * int) Ec.t -> Lambda.t -> t
