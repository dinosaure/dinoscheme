module Et: Map.S with type key = string

val eval: Type.schema Et.t -> Lambda.t -> Type.kind
