module El = Set.Make (String)

type t =
  | Word of string
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
  | Tuple of t list
  | Application of t * t
  | Primitive of string * t list

let rec recursion name = function
  | Word n -> (n = name)
  | Application (a, b) -> (recursion name a) || (recursion name b)
  | Sequence (a, b) -> (recursion name a) || (recursion name b)
  | Condition (i, a, b) -> (recursion name i) || (recursion name a) || (recursion name b)
  | List (a, b) -> (recursion name a) || (recursion name b)
  | Lambda (a, e, r) when name = a -> false
  | Lambda (a, e, r) -> (recursion name e)
  | Primitive (p, l) -> let rec check = function
                          | [] -> false
                          | x :: r -> if recursion name x then true else check r
                        in check l
  | _ -> false

let foldl f a l = List.fold_left f a l
let foldr f l a = List.fold_right f a l

let rec eval ep = function
  | Ast.Instr (Ast.Word name :: l) ->
      begin
        match El.mem name ep with
          | false -> foldl (fun x -> fun y -> Application (x, eval ep y)) (Word name) l
          | true -> Primitive (name, List.map (fun x -> eval ep x) l)
      end

  | Ast.Instr (x :: r) -> foldl (fun x -> fun y -> Application (x, eval ep y)) (eval ep x) r
  | Ast.Application (Ast.Lambda (n, a), Ast.Lambda (c, e))
    -> let e = eval ep e
       in let a = eval ep a
       in if recursion n e
       then Application (Lambda (n, a, None), Lambda (c, e, Some n))
       else Application (Lambda (n, a, None), Lambda (c, e, None))
  | Ast.Application (a, b) -> Application (eval ep a, eval ep b)
  | Ast.Sequence (a, b) -> Sequence (eval ep a, eval ep b)
  | Ast.Condition (i, a, b) -> Condition (eval ep i, eval ep a, eval ep b)
  | Ast.List (a, b) -> List (eval ep a, eval ep b)
  | Ast.Lambda (a, b) -> Lambda (a, eval ep b, None)
  | Ast.Character c -> Character c
  | Ast.Integer i -> Integer i
  | Ast.Real r -> Real r
  | Ast.Boolean b -> Boolean b
  | Ast.Word n -> Word n
  | Ast.Nill -> Nill
  | Ast.Instr []
  | Ast.Null -> Null
  | Ast.Tuple t -> Tuple (List.map (fun x -> eval ep x) t)
