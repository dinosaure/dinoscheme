module Et: Map.S with type key = string

val eval: Type.schematype Et.t -> Lambda.t -> Type.simpletype
