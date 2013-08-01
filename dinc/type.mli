type kind and schema
type short_kind and short_schema

val type_integer: kind
val type_boolean: kind
val type_real: kind
val type_character: kind
val type_arrow: kind -> kind -> kind
val type_list: kind -> kind
val type_tuple: kind array -> kind
val type_void: kind

val short_kind: string -> short_schema array -> short_schema
val short_variable: string -> short_schema
val kind_from_short_kind: short_schema -> schema

val unknown_type: unit -> kind
val schema: kind -> schema
val primitive: kind -> schema

val start_definition: unit -> unit
val stop_definition: unit -> unit

val unification: kind -> kind -> unit
val generalization: kind -> schema
val specialization: schema -> kind

val string_of_type: kind -> string 
val circularity: (kind * kind) -> string
val conflict: (kind * kind) -> string

val print_type: kind -> unit

exception Circularity of (kind * kind)
exception Conflict of (kind * kind)
