module Ep: Map.S with type key = string

type primitive = 
  | Function of (int * (primitive Ep.t -> int list -> Index.t list -> int list))
  | Constant of int

val (>>=): (primitive Ep.t * int list * Index.t list)
  -> primitive 
  -> int list

val add: string 
  -> int
  -> (primitive Ep.t -> int list -> Index.t list -> int list) 
  -> primitive Ep.t 
  -> primitive Ep.t

val default: (primitive Ep.t -> int list -> Index.t -> int list) 
  -> int 
  -> (primitive Ep.t -> int list -> Index.t list -> int list)

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
  | Variable of string * int
  | Application of t * t
  | Primitive of string * t list
