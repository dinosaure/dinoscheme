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
  | Index.Character _
  | Index.Integer _
  | Index.Real _
  | Index.Boolean _
  | Index.Null
  | Index.Nill
  | Index.Variable _
  | Index.Lambda _ -> 1
  | Index.Condition (i, a, b) -> max [eval i; eval a; eval b]
  | Index.List (a, b) -> max [eval a; 1 + eval b]
  | Index.Primitive (p, l) -> max (zip (+) (range (List.length l)) (List.map (fun x -> eval x) l))
  | Index.Application (a, b) -> max [eval a; 1 + eval b]
  | Index.Sequence (a, b) -> let a = eval a in max [a; a + eval b]
