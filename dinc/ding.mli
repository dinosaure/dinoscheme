type t =
  | Define of string * int * Type.schema
  | Apply of string * string

val print_compiler: t -> unit
val generate_environment: t list -> (Lambda.El.t * In.t In.Ep.t * Type.schema Synthesis.Et.t)
