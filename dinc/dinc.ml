(* Command-line *)

let input = ref stdin
let output = ref stdout
let rest = ref []

let usage = "usage " ^ Sys.argv.(0) ^ " input [-o output]"

let arglist = [
  ("-o", Arg.String (fun s -> output := (open_out s)), ": define output file")
]

let et = Synthesis.Et.empty
let ep = In.Ep.empty
let el = Lambda.El.empty

let el = Lambda.El.add "+" el
let el = Lambda.El.add "-" el
let el = Lambda.El.add "*" el
let el = Lambda.El.add "/" el
let el = Lambda.El.add "==" el
let el = Lambda.El.add "<>" el
let el = Lambda.El.add "hd" el
let el = Lambda.El.add "tl" el
let el = Lambda.El.add "empty" el
let el = Lambda.El.add "#chr" el
let el = Lambda.El.add "#num" el
let el = Lambda.El.add "#bln" el

let ep = In.add "+"      1   (In.default In.eval 1) ep
let ep = In.add "-"      2   (In.default In.eval 2) ep
let ep = In.add "*"      3   (In.default In.eval 3) ep
let ep = In.add "/"      4   (In.default In.eval 4) ep

let ep = In.add "=="     16  (In.default In.eval 16) ep
let ep = In.add "<>"     17  (In.default In.eval 17) ep

let ep = In.add "hd"     22  In.phd        ep
let ep = In.add "tl"     22  In.ptl        ep
let ep = In.add "empty"  23  In.pempty     ep
let ep = In.add "#chr"   9   In.pprint_chr ep
let ep = In.add "#num"   9   In.pprint_num ep
let ep = In.add "#bln"   9   In.pprint_bln ep

let et = let t = Type.primitive (Type.tarrow Type.tinteger (Type.tarrow Type.tinteger Type.tinteger))
         in let et0 = Synthesis.Et.empty
         in let et1 = Synthesis.Et.add "+" t et0
         in let et2 = Synthesis.Et.add "-" t et1
         in let et3 = Synthesis.Et.add "*" t et2
         in let et4 = Synthesis.Et.add "/" t et3
         in et4

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow a Type.tboolean))
         in let et0 = et
         in let et1 = Synthesis.Et.add "==" t et0
         in let et2 = Synthesis.Et.add "<>" t et1
         in et2

let et = let t = Type.primitive (Type.tarrow Type.tinteger (Type.tarrow Type.tinteger Type.tboolean))
         in let et0 = et
         in let et1 = Synthesis.Et.add ">"  t et0
         in let et2 = Synthesis.Et.add "<"  t et1
         in let et3 = Synthesis.Et.add ">=" t et2
         in let et4 = Synthesis.Et.add "<=" t et3
         in et4

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) Type.tboolean)
         in Synthesis.Et.add "empty" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow (Type.tlist a) (Type.tlist a)))
         in Synthesis.Et.add "push" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) a)
         in Synthesis.Et.add "hd" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) (Type.tlist a))
         in Synthesis.Et.add "tl" t et

let et = let a = Type.unknowntype ()
         in let b = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow b b))
         in Synthesis.Et.add "begin" t et

let et = let t = Type.primitive (Type.tarrow Type.tcharacter Type.tvoid)
         in Synthesis.Et.add "#chr" t et
let et = let t = Type.primitive (Type.tarrow Type.tinteger Type.tvoid)
         in Synthesis.Et.add "#num" t et
let et = let t = Type.primitive (Type.tarrow Type.tboolean Type.tvoid)
         in Synthesis.Et.add "#bln" t et

let compilator input output =
  let a = Lambda.eval el (Parser.main Lexer.lexer (Lexing.from_channel input)) in
  let _ = try Synthesis.eval et a
          with Failure s -> print_string s; print_newline (); exit 0
             | Type.Conflict s -> print_string (Type.conflict s); print_newline (); exit 0
             | Type.Circularity s -> print_string (Type.circularity s); print_newline (); exit 0 in
  let i = try Index.eval a
          with Failure s -> print_string s; print_newline (); exit 0 in
  let s = try Operation.eval i
          with Failure s -> print_string s; print_newline (); exit 0 in
  let o = try (7 :: (In.word_of_integer s)) @ (In.eval ep [ 6 ] i)
          with Failure s -> print_string s; print_newline (); exit 0 in
  List.iter (fun x -> output_byte output x) (In.tail o)

let _ =
  try Arg.parse arglist (fun x -> rest := x :: !rest) usage;
      compilator (if List.length !rest == 0 then !input else (open_in (List.hd !rest))) !output
  with Failure s -> print_string s; print_newline (); exit 0
     | Sys_error s -> print_string s; print_newline (); exit 0
