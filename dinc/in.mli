module Ep: Map.S with type key = string

type t =
  | Function of (t Ep.t -> int list -> Index.t list -> int list)
  | Constant of int

val add: string -> (t Ep.t -> int list -> Index.t list -> int list) ->
  t Ep.t -> t Ep.t

val word_of_integer: int -> int list
val word_of_boolean: bool -> int list
val word_of_real: float -> int list
val word_of_character: char -> int list

val tail: int list -> int list
val eval: t Ep.t -> int list -> Index.t -> int list
