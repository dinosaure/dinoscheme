let max l = let rec f m = function
    | [] -> m
    | x :: r -> if x > m then f x r else f m r
  in f (List.hd l) (List.tl l)

let rec zip f a b = match a with
  | [] -> []
  | x :: r -> match b with
                | [] -> []
                | h :: t -> (f x h) :: zip f r t

let rec range = function
  | 0 -> []
  | n -> (n - 1) :: range (n - 1)

let rec eval = function
  | Ast.Boolean _
  | Ast.Integer _
  | Ast.Real _
  | Ast.Character _
  | Ast.Null
  | Ast.Nill
  | Ast.Variable _
  | Ast.Word _
  | Ast.Lambda _ -> 1
  | Ast.Application (a, b) -> max [eval a; 1 + eval b]
  | Ast.Condition (i, a, b) -> max [eval i; eval a; eval b]
  | Ast.Sequence (a, b) -> let a = eval a in max [a; a + eval b]
  | Ast.Primitive (p, l) -> max (zip (+) (range (List.length l)) (List.map (fun x -> eval x) l))
  | Ast.List (a, b) -> max [eval a; 1 + eval b]
  | a -> raise (Failure ("stack: unbound element " ^ Ast.string_of_ast a))
