module Ei = Map.Make (String)

let rec indexing index env expression =
  let rec g index env = function
    | [] -> env
    | x :: r -> g (index + 1) (Ei.add x index env) r
  in match expression with
    | Ast.Word n -> (try Ast.Variable (n, index - (Ei.find n env) - 1) with _ -> raise (Failure ("index: unbound element " ^ n)))
    | Ast.Primitive (p, l) -> Ast.Primitive (p, List.map (fun x -> indexing index env x) l)
    | Ast.Application (a, b) -> Ast.Application (indexing index env a, indexing index env b)
    | Ast.List (a, b) -> Ast.List (indexing index env a, indexing index env b)
    | Ast.Sequence (a, b) -> Ast.Sequence (indexing index env a, indexing index env b)
    | Ast.Condition (i, a, b) -> Ast.Condition (indexing index env i, indexing index env a, indexing index env b)
    | Ast.Lambda (arg, exp, sta) -> begin
                                      match sta with
                                        | Some name -> Ast.Lambda (arg, indexing (index + 2) (g index env (name :: [arg])) exp, sta)
                                        | None -> Ast.Lambda (arg, indexing (index + 1) (g index env [arg]) exp, sta)
                                    end
    | a -> a

let eval = indexing 0 Ei.empty
