val char_of_backslash: char -> char
val char_of_hexa: char -> char -> char
val int_of_hexa_string: string -> int

val string_of: string -> int ref -> unit -> string

val explode: string -> char list

val foldl: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
val foldr: ('a -> 'b -> 'b) -> 'b -> 'a list -> 'b
