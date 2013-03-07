module L = Llvm
module Eo = Map.Make (String)

let ctxt          = L.global_context ()
let modl          = L.create_module ctxt "identity"
let bldr          = L.builder ctxt
let type_i        = L.i32_type ctxt
let type_e size   = L.array_type type_i size
let type_f        = L.function_type type_i [| type_i; type_i |] 
let type_c        = L.struct_type ctxt [| L.pointer_type type_f; type_i |]

let cofunction    = ref 0
let coenvironment = ref 0

let string_of prefix counter () =
  let name = (String.make 1 (char_of_int (int_of_char 'a' + (!counter mod 26)))) ^ 
             (if !counter >= 26 then (string_of_int (!counter / 26)) else "")
  in incr counter; prefix ^ name

let string_of_function = string_of "f" cofunction
let string_of_environment = string_of "e" coenvironment

type expression =
  | Integer of int
  | Variable of string * int
  | Lambda of string * expression
  | Application of expression * expression
  | Addition of expression * expression

let prototype () =
  let argm = [| "x"; "e" |] in
  let name = string_of_function () in
  let func = match L.lookup_function name modl with
    | None -> L.declare_function name type_f modl
    | Some _ -> raise (Failure ("Redefinition of " ^ name))
  in
  let _ =
    Array.iteri
    (fun i x -> let n = argm.(i) in L.set_value_name n x)
    (L.params func)
  in func

let create_closure func varx vare size =

  let envr = L.build_malloc (type_e (size + 1)) "envr" bldr in 
  let envp = L.build_inttoptr vare (L.pointer_type (type_e size)) "envp" bldr in 
  let clos = L.build_malloc type_c "clos" bldr in

  let rec assignation = function
    | 0 -> L.build_store
           varx
           (L.build_gep envp [| L.const_int type_i 0; L.const_int type_i 0 |] "" bldr)
    | n -> let _ = L.build_store
           (L.build_load (L.build_gep envp [| L.const_int type_i 0; L.const_int type_i (n - 1) |] "" bldr) "" bldr)
           (L.build_gep envr [| L.const_int type_i 0; L.const_int type_i n |] "" bldr)
           bldr
           in assignation (n - 1) 
  let func = eval (argm, envp)
  let _ = L.build_store
          func
          (L.build_struct_gep clos 0 "" bldr)
          bldr in
  let _ = L.build_store
          (L.build_ptrtoint envr type_i "" bldr)
          (L.build_struct_gep clos 1 "" bldr)
          bldr in
  let rec assignation = function
    | 0 -> L.build_store
           varx
           (L.build_gep envp [| L.const_int type_i 0; L.const_int type_i 0 |] "" bldr)
    | n -> let _ = L.build_store
           (L.build_load (L.build_gep envp [| L.const_int type_i 0; L.const_int type_i (n - 1) |] "" bldr) "" bldr)
           (L.build_gep envr [| L.const_int type_i 0; L.const_int type_i n |] "" bldr)
           bldr
           in assignation (n - 1) 
  in
  let _ = assignation size in
  clos

let create_closure lambda environment =

let rec eval (varx, vare, size) = function
  | Integer i -> L.const_int type_i i
  | Variable (_, 0) -> varx
  | Variable (_, n) ->
      let envr = L.build_inttoptr vare (L.pointer_type (type_e size)) "" bldr in
      L.build_load (L.build_gep envr [| L.const_int type_i 0; L.const_int type_i n |] "" bldr) "" bldr
  | Lambda (_, expression) ->
      let func = create_function expression size in
      L.build_ptrtoint (create_closure func varx vare size) type_i "" bldr
  | Application (lambda, argument) ->
          let clop = L.build_inttoptr (eval (varx, vare, size + 1) lambda) (L.pointer_type type_c) "clop" bldr in
          let argm = eval (varx, vare, 0) argument in
          L.build_call
            (L.build_load (L.build_struct_gep clop 0 "" bldr) "" bldr)
            [| argm; (L.build_load (L.build_struct_gep clop 1 "" bldr) "" bldr) |]
            "" bldr

and create_function expression size =
  let func = prototype () in
  let oldb = L.insertion_block bldr in
  let newb = L.append_block ctxt "entry" func in
  let _    = L.position_at_end newb bldr in
  let vret = eval ((L.params func).(0), (L.params func).(1), size + 1) expression in
  let _    = L.build_ret vret bldr in
  let _    = L.position_at_end oldb bldr in
  func

let main root =
  let execute expression =
    match expression with
      | Application (lambda, argument) ->
          let envr = L.build_alloca (type_e 0) "envr" bldr in
          let argm = eval (L.const_null type_i, L.const_null type_i, 0) argument in
          let clop = L.build_inttoptr (eval (argm, envr, 0) lambda) (L.pointer_type type_c) "clop" bldr in
          L.build_call
            (L.build_load (L.build_struct_gep clop 0 "" bldr) "" bldr)
            [| argm; (L.build_load (L.build_struct_gep clop 1 "" bldr) "" bldr) |]
            "" bldr
(*
          L.build_call
          (L.build_load (L.build_struct_gep closure 0 "" bldr) "" bldr)
          [| (L.build_load (L.build_struct_gep closure 1 "" bldr) "" bldr) |]
          "" bldr
*)
  in
  let main = L.declare_function "main" (L.function_type type_i [||]) modl in
  let main_block = L.append_block ctxt "entry" main in
  let _ = L.position_at_end main_block bldr in
  try let ret = execute root in L.build_ret ret bldr
  with e -> let _ = L.delete_function main in raise e

let () =
  let _ = main (Application ((Application ((Lambda ("x", (Lambda ("y", (Variable
  ("x", 1)))))), Integer 42)), Integer 21)) in
  L.dump_module modl;
