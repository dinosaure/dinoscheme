open Primitive
open Ast
open Type
open Synthesis
open Operation
open Opcode

(* Command-line *)

let input = ref stdin
let output = ref stdout
let rest = ref []

let usage = "usage " ^ Sys.argv.(0) ^ " input [-o output]"

let arglist = [
  ("-o", Arg.String (fun s -> output := (open_out s)), ": define output file")
]

let et = Et.empty
let ep = Ep.empty

let ep = Primitive.add "+" 1 (Primitive.default Opcode.eval 1) ep
let ep = Primitive.add "-" 2 (Primitive.default Opcode.eval 2) ep
let ep = Primitive.add "*" 3 (Primitive.default Opcode.eval 3) ep
let ep = Primitive.add "/" 4 (Primitive.default Opcode.eval 4) ep

let ep = Primitive.add "==" 16 (Primitive.default Opcode.eval 16) ep
let ep = Primitive.add "<>" 17 (Primitive.default Opcode.eval 17) ep

let ep = Primitive.add "hd"     22  Opcode.phd        ep
let ep = Primitive.add "tl"     22  Opcode.ptl        ep
let ep = Primitive.add "empty"  23  Opcode.pempty     ep
let ep = Primitive.add "#chr"   9   Opcode.pprint_chr ep
let ep = Primitive.add "#num"   9   Opcode.pprint_num ep
let ep = Primitive.add "#bln"   9   Opcode.pprint_bln ep

let et = let t = Type.primitive (Type.tarrow Type.tinteger (Type.tarrow Type.tinteger Type.tinteger))
         in let et0 = Et.empty
         in let et1 = Et.add "+" t et0
         in let et2 = Et.add "-" t et1
         in let et3 = Et.add "*" t et2
         in let et4 = Et.add "/" t et3
         in et4

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow a Type.tboolean))
         in let et0 = et
         in let et1 = Et.add "==" t et0
         in let et2 = Et.add "<>" t et1
         in et2

let et = let t = Type.primitive (Type.tarrow Type.tinteger (Type.tarrow Type.tinteger Type.tboolean))
         in let et0 = et
         in let et1 = Et.add ">"  t et0
         in let et2 = Et.add "<"  t et1
         in let et3 = Et.add ">=" t et2
         in let et4 = Et.add "<=" t et3
         in et4

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) Type.tboolean)
         in Et.add "empty" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow (Type.tlist a) (Type.tlist a)))
         in Et.add "push" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) a)
         in Et.add "hd" t et

let et = let a = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow (Type.tlist a) (Type.tlist a))
         in Et.add "tl" t et

let et = let a = Type.unknowntype ()
         in let b = Type.unknowntype ()
         in let t = Type.primitive (Type.tarrow a (Type.tarrow b b))
         in Et.add "begin" t et

let et = let t = Type.primitive (Type.tarrow Type.tcharacter Type.tvoid)
         in Et.add "#chr" t et
let et = let t = Type.primitive (Type.tarrow Type.tinteger Type.tvoid)
         in Et.add "#num" t et
let et = let t = Type.primitive (Type.tarrow Type.tboolean Type.tvoid)
         in Et.add "#bln" t et

let compilator input output =
  let a = Lambda.eval ep (Parser.main Lexer.lexer (Lexing.from_channel input)) in
  let i = try Index.eval a
          with Failure s -> print_string s; print_newline (); exit 0 in
  let _ = try Synthesis.eval et i
          with Failure s -> print_string s; print_newline (); exit 0
             | Conflict s -> print_string (conflict s); print_newline (); exit 0
             | Circularity s -> print_string (circularity s); print_newline (); exit 0 in
  let s = try Operation.eval i
          with Failure s -> print_string s; print_newline (); exit 0 in
  let o = try (7 :: (Opcode.word_of_integer s)) @ (Opcode.eval ep [ 6 ] i)
          with Failure s -> print_string s; print_newline (); exit 0 in
  List.iter (fun x -> output_byte output x) (Opcode.tail o)

let _ =
  try Arg.parse arglist (fun x -> rest := x :: !rest) usage;
      compilator (if List.length !rest == 0 then !input else (open_in (List.hd !rest))) !output
  with Failure s -> print_string s; print_newline (); exit 0
     | Sys_error s -> print_string s; print_newline (); exit 0
