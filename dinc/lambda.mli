open Primitive
open Ast

val recursion: string -> Ast.expression -> bool

val eval: Primitive.primitive Primitive.Ep.t -> Ast.expression -> Ast.expression
