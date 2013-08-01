let input = ref stdin
let output = ref stdout
let compiler = ref None
let rest = ref []

let usage = "usage " ^ Sys.argv.(0) ^ " input [-o output]"

let arglist = [
  ("-o", Arg.String (fun s -> output := (open_out s)), ": define output file");
  ("-i", Arg.String (fun s -> compiler := Some (open_in s)),
    ": define compiler file")
]

let compilator (el, ep, et) input output =
  let a = Lambda.eval el (Pinc.main Linc.lexer (Lexing.from_channel input)) in
  let _ = 
    try Synthesis.eval et a
    with Failure s -> print_string s; print_newline (); exit 0
       | Type.Conflict s -> print_string (Type.conflict s);
       print_newline (); exit 0
       | Type.Circularity s -> print_string (Type.circularity s);
       print_newline (); exit 0 in
  let i = try Index.eval a
    with Failure s -> print_string s; print_newline (); exit 0 in
  let s = try Operation.eval i
    with Failure s -> print_string s; print_newline (); exit 0 in
  let o = try (7 :: (In.word_of_integer s)) @ (In.eval ep [ 6 ] i)
    with Failure s -> print_string s; print_newline (); exit 0 in
  List.iter (fun x -> output_byte output x) (In.tail o)

let () =
  try Arg.parse arglist (fun x -> rest := x :: !rest) usage;
    let (el, ep, et) = match !compiler with
      | None -> (Lambda.El.empty, In.Ep.empty, Synthesis.Et.empty)
      | Some o -> Ding.generate_environment
        (Ping.main Ling.lexer (Lexing.from_channel o))
    in compilator (el, ep, et)
      (if List.length !rest == 0 then !input else (open_in (List.hd !rest))) !output
  with Failure s -> print_string s; print_newline (); exit 0
     | Sys_error s -> print_string s; print_newline (); exit 0
