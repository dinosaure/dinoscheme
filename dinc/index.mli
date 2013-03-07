open Ast

module Ei: Map.S with type key = string 

val indexing: int -> int Ei.t -> Ast.expression -> Ast.expression 
val eval: Ast.expression -> Ast.expression
