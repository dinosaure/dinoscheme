type t =
  | Define of string * int * Type.schema
  | Apply of string * string

let print_compiler = function
  | Define (name, opcode, kind) ->
    print_string "val "; print_string name; print_string ": ";
    Type.print_type (Type.specialization kind)
  | _ -> ()

let generate_environment l =
  let rec aux (el, ep, et) = function
    | [] -> (el, ep, et)
    | (Define (name, opcode, kind)) :: r ->
      aux (Lambda.El.add name el,
        In.add name (Primitive.default opcode) ep,
        Synthesis.Et.add name kind et) r
    | (Apply (name, apply)) :: r ->
      try let f = Primitive.find apply
      in aux (el, In.add name f ep, et) r
      with _ -> raise (Failure (name ^ " has not primitive"))
  in aux (Lambda.El.empty, In.Ep.empty, Synthesis.Et.empty) l
