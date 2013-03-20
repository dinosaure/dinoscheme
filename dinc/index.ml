module Ei = Map.Make (String)

type t =
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * t * string option
  | List of t * t
  | Sequence of t * t
  | Condition of t * t * t
  | Nill
  | Null
  | Variable of string * int
  | Application of t * t
  | Primitive of string * t list

let rec indexing index env expression =
  let rec g index env = function
    | [] -> env
    | x :: r -> g (index + 1) (Ei.add x index env) r
  in match expression with
    | Lambda.Word n -> (try Variable (n, index - (Ei.find n env) - 1) with _ -> raise (Failure ("index: unbound element " ^ n)))
    | Lambda.Primitive (p, l) -> Primitive (p, List.map (fun x -> indexing index env x) l)
    | Lambda.Application (a, b) -> Application (indexing index env a, indexing index env b)
    | Lambda.List (a, b) -> List (indexing index env a, indexing index env b)
    | Lambda.Sequence (a, b) -> Sequence (indexing index env a, indexing index env b)
    | Lambda.Condition (i, a, b) -> Condition (indexing index env i, indexing index env a, indexing index env b)
    | Lambda.Lambda (arg, exp, sta) -> begin match sta with
                                         | Some name -> Lambda (arg, indexing (index + 2) (g index env (name :: [arg])) exp, sta)
                                         | None -> Lambda (arg, indexing (index + 1) (g index env [arg]) exp, sta)
                                       end
    | Lambda.Character c -> Character c
    | Lambda.Integer i -> Integer i
    | Lambda.Real r -> Real r
    | Lambda.Boolean b -> Boolean b
    | Lambda.Null -> Null
    | Lambda.Nill -> Nill

let eval exp = indexing 0 Ei.empty exp
