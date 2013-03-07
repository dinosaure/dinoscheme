module Sc = Set.Make (String)
module Ec = Map.Make (String)

type t =
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool
  | Nill
  | Null
  | Application of t * t
  | Closure of lambda * environment
  | Get of string * int
  | Variable of string
  | Condition of t * t * t
  | List of t * t
  | Sequence of t * t
  | Primitive of string * t list
and lambda = string * string * t * string option
and environment = (int * string) list

let foldl f a l = List.fold_left f a l

let ecount = ref 0
let string_of_environment = Utils.string_of "e" ecount

let rec free = function
  | Lambda.Character _
  | Lambda.Integer _
  | Lambda.Real _
  | Lambda.Boolean _
  | Lambda.Nill
  | Lambda.Null -> Sc.empty
  | Lambda.List (a, b) -> Sc.union (free a) (free b)
  | Lambda.Sequence (a, b) -> Sc.union (free a) (free b)
  | Lambda.Condition (a, b, c) -> Sc.union (free a) (Sc.union (free b) (free c))
  | Lambda.Word name -> Sc.singleton name
  | Lambda.Primitive (p, l) -> foldl (fun x y -> Sc.union x (free y)) Sc.empty l
  | Lambda.Lambda (arg, exp, _) -> Sc.diff (free exp) (Sc.singleton arg)
  | Lambda.Application (a, b) -> Sc.union (free a) (free b)

let environment s = Sc.fold (fun x l -> (List.length l, x) :: l) s []
let extend e l n  = foldl (fun e x -> Ec.add (snd x) (n, fst x) e) e l

let rec eval env exp = match exp with
  | Lambda.Character c -> Character c
  | Lambda.Integer i -> Integer i
  | Lambda.Real r -> Real r
  | Lambda.Boolean b -> Boolean b
  | Lambda.Nill -> Nill
  | Lambda.Null -> Null
  | Lambda.Condition (i, a, b) ->
      Condition (eval env i, eval env a, eval env b)
  | Lambda.List (a, b) ->
      List (eval env a, eval env b)
  | Lambda.Sequence (a, b) ->
      Sequence (eval env a, eval env b)
  | Lambda.Primitive (p, l) -> Primitive (p, List.map (fun x -> eval env x) l)
  | Lambda.Application (a, b) -> Application (eval env a, eval env b)
  | Lambda.Word s ->
      begin try let (name, id) = Ec.find s env in Get (name, id)
      with _ -> Variable s end
  | Lambda.Lambda (arg, bod, sta) ->
      let name = string_of_environment () in
      let free = free exp in
      let envr = environment free in
      Closure (lambda arg name (eval (extend env envr name) bod) sta, envr)
and lambda arg env exp sta = (arg, env, exp, sta)
