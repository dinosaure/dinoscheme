let (>>=) = Primitive.(>>=)

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> a * (pow a (n - 1))

let foldr f l a = List.fold_right f l a

let rec make n v = match n with
  | 0 -> []
  | n -> v :: make (n - 1) v

let abs n = if n < 0 then -n else n

(* 
 *  Le CHAR fait toujours 8 bits (cc gnomnain)
 *)

let word_of_integer n = let rec aux n l = match n with
    | 0 -> l
    | n -> aux (n / 256) ((n mod 256) :: l)
  in let bit i = i lor (1 lsl 7)
  in let result = aux (abs n) []
  in let result = (make (4 - List.length result) 0) @ result
  in if n < 0 then (bit (List.hd result)) :: (List.tl result)
              else result

let word_of_boolean b = if b then word_of_integer 1 else word_of_integer 0
let word_of_real r = word_of_integer (int_of_float r)
let word_of_character c = word_of_integer (int_of_char c)

(*
 *  MACRO -> "wd" <=> 00
 *           "ld" <=> 0C
 *           
 *  Changer la sémantique de la chaîne de caractère
 *  La chaîne correspondera retournera un char selon
 *  le dictionnaire de Primitive
 *
 *)

let rec tail = function
  | [] -> []
  | 13 :: 14 :: r -> 19 :: 20 :: (tail r)
  | x :: r -> x :: (tail r)

let rec eval env o = function
  | Ast.Boolean b           -> 0 :: ((word_of_boolean b) @ o)
  | Ast.Integer i           -> 0 :: ((word_of_integer i) @ o)
  | Ast.Real r              -> 0 :: ((word_of_real r) @ o)
  | Ast.Character c         -> 0 :: ((word_of_character c) @ o)

  | Ast.Variable (n, i)     -> 12 :: ((word_of_integer i) @ o)

  | Ast.Lambda (n, c, r)    -> let cs = eval env [14] c
                               in let cr = begin match r with
                                 | Some n -> true
                                 | None -> false end
                               in ((if cr == true then 18 else 10) :: 
                                  (word_of_integer (Operation.eval c))) @ 
                                  (11 :: (word_of_integer (List.length cs))) @ 
                                  cs @ o

  | Ast.Condition (i, a, b) -> let bo = eval env [] b
                               in let ao = eval env (11 :: (word_of_integer (List.length bo))) a
                               in let io = eval env (15 :: (word_of_integer (List.length ao))) i
                               in io @ ao @ bo @ o

  | Ast.Application (a, b)  -> (eval env (eval env [13] b) a) @ o

  | Ast.Primitive (s, l)    -> begin try (env, o, l) >>= (Primitive.Ep.find s env)
                               with _ -> raise (Failure ("opcode: unbound primitive " ^ s)) end

  | Ast.List (x, r)         -> eval env (eval env (21 :: ((word_of_integer 2) @ o)) r) x

  | Ast.Nill                -> 21 :: ((word_of_integer 0) @ o)

  | Ast.Null                -> 21 :: ((word_of_integer 0) @ o)

  | Ast.Sequence (a, b)     -> eval env (eval env o b) a

  | a                       -> raise (Failure ("opcode: unbound element " ^ Ast.string_of_ast a))

let string_of_opcode o =
  let rec f buffer = function
    | [] -> Buffer.contents buffer
    | x :: r -> Buffer.add_char buffer x;
                f buffer r
  in f (Buffer.create 16) o

let phd env o = function
  | [ expr ] -> eval env (22 :: ((word_of_integer 0) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use hd primitive"))

let ptl env o = function
  | [ expr ] -> eval env (22 :: ((word_of_integer 1) @ o)) expr
  | _ -> raise (Failure ("opcode: rror in use tl primitive"))

let pempty env o = function
  | [ expr ] -> eval env (23 :: o) expr
  | _ -> raise (Failure ("opcode: error in use empty primitive"))

let pprint t env o = function
  | [ expr ] -> eval env (9 :: ((word_of_integer t) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use print primitive"))

let pprint_chr = pprint 1
let pprint_num = pprint 2
let pprint_bln = pprint 3
