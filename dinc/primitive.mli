open Ast

module Ep: Map.S with type key = string

type primitive = 
  | Function of (int * (primitive Ep.t -> int list -> Ast.expression list -> int list))
  | Constant of int

val (>>=): (primitive Ep.t * int list * Ast.expression list)
           -> primitive 
           -> int list

val add: string 
         -> int
         -> (primitive Ep.t -> int list -> Ast.expression list -> int list) 
         -> primitive Ep.t 
         -> primitive Ep.t

val default: (primitive Ep.t -> int list -> Ast.expression -> int list) 
             -> int 
             -> (primitive Ep.t -> int list -> Ast.expression list -> int list)
