type simpletype and schematype

val tinteger: simpletype
val tboolean: simpletype
val treal: simpletype
val tcharacter: simpletype
val tarrow: simpletype -> simpletype -> simpletype
val tlist: simpletype -> simpletype
val tvoid: simpletype

val unknowntype: unit -> simpletype
val schema: simpletype -> schematype
val primitive: simpletype -> schematype

val start_definition: unit -> unit
val stop_definition: unit -> unit

val unification: simpletype -> simpletype -> unit
val generalization: simpletype -> schematype
val specialization: schematype -> simpletype

val string_of_type: simpletype -> string 
val circularity: (simpletype * simpletype) -> string
val conflict: (simpletype * simpletype) -> string

val print_type: simpletype -> unit

exception Circularity of (simpletype * simpletype)
exception Conflict of (simpletype * simpletype)
