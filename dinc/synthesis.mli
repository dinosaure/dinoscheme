open Ast
open Type

module Et: Map.S with type key = string

val eval: Type.schematype Et.t -> Ast.expression -> Type.simpletype
