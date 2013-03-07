type expression =
  | Lambda of string * expression
  | Application of expression * expression
  | Variable of string * int
  | Integer of int

let rec subst name value = function
  | Lambda (arg, exp) ->
      if arg <> name
      then Lambda (arg, subst name value exp)
      else Lambda (arg, exp)
  | Application (lam, arg) ->
      Application (subst name value lam, subst name value arg)
  | Variable (id, indice) ->
      if id = name
      then value
      else Variable (id, indice)
  | a -> a

let rec eval = function
  | Application (lam, value) ->
      let lam = match lam with
        | Lambda (name, exp) -> eval (subst name value exp)
        | x -> x
      in Application (lam, value)
  | x -> x
