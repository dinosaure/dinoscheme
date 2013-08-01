let map = Hashtbl.create ~random:true 256
let foldr f a l = List.fold_right f l a

let default code =
  (fun e l a -> foldr (fun x o -> In.eval e o x) (code :: l) a)

let hd env o = function
  | [ expr ] -> In.eval env (22 :: ((In.word_of_integer 0) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use hd primitive"))

let tl env o = function
  | [ expr ] -> In.eval env (22 :: ((In.word_of_integer 1) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use tl primitive"))

let empty env o = function
  | [ expr ] -> In.eval env (23 :: o) expr
  | _ -> raise (Failure ("opcode: error in use empty primitive"))

let print t env o = function
  | [ expr ] -> In.eval env (9 :: ((In.word_of_integer t) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use print primitive"))

let fst env o = function
  | [ expr ] -> In.eval env (22 :: ((In.word_of_integer 0) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use fst primitive"))

let snd env o = function
  | [ expr ] -> In.eval env (22 :: ((In.word_of_integer 1) @ o)) expr
  | _ -> raise (Failure ("opcode: error in use snd primitive"))

let print_chr = print 1
let print_num = print 2
let print_bln = print 3
let find = Hashtbl.find map

let () =
  Hashtbl.add map "hd" hd;
  Hashtbl.add map "tl" tl;
  Hashtbl.add map "empty" empty;

  Hashtbl.add map "print_chr" print_chr;
  Hashtbl.add map "print_num" print_num;
  Hashtbl.add map "print_bln" print_bln;

  Hashtbl.add map "fst" fst;
  Hashtbl.add map "snd" snd;
