module Ep: Map.S with type key = string

type t =
  | Function of (int * f)
  | Constant of int
and f = t Ep.t -> int list -> Index.t list -> int list
and d = t Ep.t -> int list -> Index.t -> int list

val add: string -> int -> f -> t Ep.t -> t Ep.t
val default: d -> int -> f


val word_of_integer: int -> int list
val word_of_boolean: bool -> int list
val word_of_real: float -> int list
val word_of_character: char -> int list

val tail: int list -> int list
val eval: d

val phd:        f
val ptl:        f
val pempty:     f
val pprint_chr: f
val pprint_num: f
val pprint_bln: f
