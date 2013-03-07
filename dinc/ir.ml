module L = Llvm

type global = { ctxt: L.llcontext;
                modl: L.llmodule;
                bldr: L.llbuilder; }

let init name =
  let ctxt = L.global_context () in
  { ctxt = ctxt;
    modl = L.create_module ctxt name;
    bldr = L.builder ctxt }

let g_int g = L.i32_type g.ctxt
let g_environment g size = L.array_type (g_int g) size
let g_function g = L.function_type (g_int g) [| (g_int g); (g_int g) |]
let g_closure g = L.struct_type g.ctxt
                  [| L.pointer_type (g_function g); (g_int g) |]

let fcount = ref 0
let string_of_function = Utils.string_of "f" fcount

let g_prototype g n_arg n_env =
  let argm = [| n_arg; n_env |] in
  let name = string_of_function () in
  let proc = match L.lookup_function name g.modl with
    | None -> L.declare_function name (g_function g) g.modl
    | Some _ -> raise (Failure ("Redefinition of " ^ name))
  in let _ =
    Array.iteri
    (fun i x -> let n = argm.(i) in L.set_value_name n x)
    (L.params proc)
  in proc


let rec g_eval g env = function
  | Closure.Integer i -> L.const_int (g_int g) i
  | Closure.Application (a, b) ->
      let closure = L.build_inttoptr (g_eval g env a) (L.pointer_type (g_closure g)) "" g.bldr in
      let argument = g_eval g env b in
      L.build_call
        (L.build_load (L.build_struct_gep closure 0 "" g.bldr) "" g.bldr)
        [| argument; L.build_load (L.build_struct_gep closure 1 "" g.bldr) "" g.bldr |]
        "" g.bldr
  | Closure.Closure ((n_arg, n_env, n_exp, _), n_list) ->
      let func = g_func g n_arg n_env n_exp in
      let envr = g_envr g n_list in
      let clos = g_clos g func envr in
      L.build_ptrtoint clos (g_int g) "" g.bldr
  | _ -> L.const_int (g_int g) 1337
  (* | Closure (lambda, environemnt) -> *)
and g_func g n_arg n_env n_exp =
  let func = g_prototype g n_arg n_env in
  let oldb = L.insertion_block g.bldr in
  let newb = L.append_block g.ctxt "entry" func in
  let _    = L.position_at_end newb g.bldr in
  let vret = g_eval g ((L.params func).(0), (L.params func).(1)) n_exp in
  let _    = L.build_ret vret g.bldr in
  let _    = L.position_at_end oldb g.bldr in
  func
and g_envr g n_list =
  L.build_malloc (g_environment g (List.length n_list)) "envr" g.bldr
and g_clos g n_func n_envr =
  let clos = L.build_malloc (g_closure g) "" g.bldr in
  let _    = L.build_store n_func (L.build_struct_gep clos 0 "" g.bldr) g.bldr in
  let _    = L.build_store
              (L.build_ptrtoint n_envr (g_int g) "" g.bldr)
              (L.build_struct_gep clos 1 "" g.bldr) g.bldr in
  clos
  


let eval name pgrm =
  let g = (init name) in
  let _ = g_eval g (L.const_null (g_int g), L.const_null (g_int g)) pgrm in
  L.dump_module g.modl
