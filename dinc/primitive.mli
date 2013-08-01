val default: int -> (In.t In.Ep.t -> int list -> Index.t list -> int list)

val hd:        In.t In.Ep.t -> int list -> Index.t list -> int list
val tl:        In.t In.Ep.t -> int list -> Index.t list -> int list
val empty:     In.t In.Ep.t -> int list -> Index.t list -> int list
val print_chr: In.t In.Ep.t -> int list -> Index.t list -> int list
val print_num: In.t In.Ep.t -> int list -> Index.t list -> int list
val print_bln: In.t In.Ep.t -> int list -> Index.t list -> int list
val fst:       In.t In.Ep.t -> int list -> Index.t list -> int list
val snd:       In.t In.Ep.t -> int list -> Index.t list -> int list

val find: string -> (In.t In.Ep.t -> int list -> Index.t list -> int list)
