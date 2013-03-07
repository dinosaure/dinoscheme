open Ast
open Primitive
open Stack

val word_of_integer: int -> int list
val word_of_boolean: bool -> int list
val word_of_real: float -> int list
val word_of_character: char -> int list

val tail: int list -> int list
val eval: Primitive.primitive Ep.t -> int list -> Ast.expression -> int list

val phd:        Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
val ptl:        Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
val pempty:     Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
val pprint_chr: Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
val pprint_num: Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
val pprint_bln: Primitive.primitive Ep.t -> int list -> Ast.expression list -> int list
