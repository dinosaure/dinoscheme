module Ep = Map.Make (String)

type primitive = 
  | Function of (int * (primitive Ep.t -> int list -> Ast.expression list -> int list))
  | Constant of int

let foldr f a l = List.fold_right f l a

let (>>=) (e, l, a) = function
  | Function (o, f) -> f e l a
  | Constant o -> raise (Failure ("primitive: this primitive is not applicable"))

let add name code primitive = Ep.add name (Function (code, primitive))
let default eval code = fun p -> fun l -> fun a -> foldr (fun x -> fun o -> eval p o x) (code :: l) a
