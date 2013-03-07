let rec recursion name = function
  | Ast.Word n -> (n = name)
  | Ast.Application (a, b) -> (recursion name a) || (recursion name b)
  | Ast.Sequence (a, b) -> (recursion name a) || (recursion name b)
  | Ast.Condition (i, a, b) -> (recursion name i) || (recursion name a) || (recursion name b)
  | Ast.List (a, b) -> (recursion name a) || (recursion name b)
  | Ast.Lambda (a, e, r) -> (recursion name e)
  | Ast.Primitive (p, l) -> let rec check = function
                              | [] -> false
                              | x :: r -> if recursion name x then true else check r
                            in check l
  | _ -> false

let foldl f a l = List.fold_left f a l
let foldr f l a = List.fold_right f a l

let rec eval ep = function
  | Ast.Instr (Ast.Word name :: l) -> begin
                                        match Primitive.Ep.mem name ep with
                                          | false -> foldl (fun x -> fun y -> Ast.Application (x, eval ep y)) (Ast.Word name) l
                                          | true -> Ast.Primitive (name, List.map (fun x -> eval ep x) l)
                                      end

  | Ast.Instr (x :: r) -> foldl (fun x -> fun y -> Ast.Application (x, eval ep y)) (eval ep x) r
  | Ast.Application (Ast.Lambda (n, a, b), Ast.Lambda (c, e, d))
    -> let e = eval ep e
       in let a = eval ep a
       in if recursion n e
       then Ast.Application (Ast.Lambda (n, a, b), Ast.Lambda (c, e, Some n))
       else Ast.Application (Ast.Lambda (n, a, b), Ast.Lambda (c, e, None))
  | Ast.Application (a, b) -> Ast.Application (eval ep a, eval ep b)
  | Ast.Sequence (a, b) -> Ast.Sequence (eval ep a, eval ep b)
  | Ast.Condition (i, a, b) -> Ast.Condition (eval ep i, eval ep a, eval ep b)
  | Ast.List (a, b) -> Ast.List (eval ep a, eval ep b)
  | Ast.Lambda (a, b, c) -> Ast.Lambda (a, eval ep b, c)
  | a -> a
