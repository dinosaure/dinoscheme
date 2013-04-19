type simpletype =
  | Variable of nametype
  | Word of string * simpletype array
and valuetype =
  | Unknown
  | Known of simpletype
and nametype = { mutable level: int;
                 mutable value: valuetype }
and schematype = { parameters: nametype list;
                    content: simpletype }

exception Circularity of (simpletype * simpletype)
exception Conflict of (simpletype * simpletype)

let tinteger      = Word ("integer",    [||])
let tboolean      = Word ("boolean",    [||])
let treal         = Word ("real",       [||])
let tcharacter    = Word ("character",  [||])
let tarrow a b    = Word ("->",         [|a; b|])
let tlist t       = Word ("list",       [|t|])
let ttuple e      = Word ("*",          e)
let tvoid         = Word ("void",       [||])

let l = ref 0

let start_definition () = incr l
let stop_definition () = decr l

let unknowntype () = Variable { level = !l; value = Unknown }

let rec value_of = function
  | Variable ({value = Known ty} as var) ->
    let value_of_ty = value_of ty in 
    var.value <- Known value_of_ty;
    value_of_ty 
  | ty -> ty

let rec setlevel m ty = match value_of ty with 
  | Variable var -> if var.level > m then var.level <- m
  | Word (w, a) -> Array.iter (setlevel m) a

let name_of_variables = ref ([] : (nametype * string) list)
and c = ref 0

let string_of_variable var =
  try
    (List.assq var !name_of_variables)
  with Not_found -> let name = (String.make 1 (char_of_int (int_of_char 'a' + (!c mod 26)))) ^
                               (if !c >= 26 then (string_of_int (!c / 26)) else "")
  in incr c;
     name_of_variables := (var, name) :: !name_of_variables;
     name

let rec string_of_type ty = match value_of ty with
  | Variable var -> string_of_variable var
  | Word (w, a) -> let b = Buffer.create 16
                   in let f w a b = match Array.length a with
                    | 0 -> Buffer.add_string b w
                    | 1 -> Buffer.add_string b (string_of_type a.(0));
                           Buffer.add_char b ' ';
                           Buffer.add_string b w
                    | _ -> let s w a b =
                           Buffer.add_char b '(';
                             for i = 0 to Array.length a - 1 do
                               Buffer.add_string b (string_of_type a.(i));
                               if i + 1 < Array.length a then
                                 begin Buffer.add_char b ' ';
                                       Buffer.add_string b w;
                                       Buffer.add_char b ' ';
                                 end;
                             done;
                           Buffer.add_char b ')'
                   in s w a b in f w a b;
                   Buffer.contents b

let circularity (ta, tb) = "circularity between " ^ string_of_type ta ^ " and " ^ string_of_type tb
let conflict (ta, tb) = "conflict between " ^ string_of_type ta ^ " and " ^ string_of_type tb

let has_name var ty = 
  let rec test ty =
    match ty with
      | Variable ovar -> if var == ovar then raise (Circularity ((Variable var), ty))
      | Word (w, a) -> Array.iter test a
  in test ty

let rec unification ty1 ty2 =
  let v1 = value_of ty1
  and v2 = value_of ty2 in 
  if v1 == v2 then () else
  match (v1, v2) with
    | Variable var, ty -> has_name var ty;
                          setlevel var.level ty;
                          var.value <- Known ty;
    | ty, Variable var -> has_name var ty;
                          setlevel var.level ty;
                          var.value <- Known ty;
    | Word (w1, a1), Word (w2, a2) -> if w1 <> w2 then
                                        raise (Conflict (v1, v2))
                                      else
                                        for i = 0 to Array.length a1 - 1 do
                                          try unification a1.(i) a2.(i)
                                          with _ -> raise (Conflict (v1, v2))
                                        done

let generate_schema ty m = 
  let parameters = ref [] in 
  let rec find_parameters ty =
    match value_of ty with
      | Variable var -> if (var.level > !l && m == true || m == false) && (List.memq var !parameters) == false
        then parameters := var :: !parameters
      | Word (w, a) -> Array.iter find_parameters a 
  in find_parameters ty; { parameters = !parameters; content = ty }

let generalization ty = generate_schema ty true

let specialization schema = 
  match schema.parameters with 
    | [] -> schema.content
    | parameters -> let newunknown = List.map (fun var -> (var, unknowntype ())) parameters
                    in let rec copy ty = match value_of ty with
                      | Variable var as ty -> (try List.assq var newunknown with Not_found -> ty)
                      | Word (w, a) -> Word (w, Array.map copy a)
                    in copy schema.content

let schema ty = { parameters = []; content = ty }
let primitive ty = generate_schema ty false

let print_type ty = name_of_variables := [];
                    c := 0; 
                    print_string (string_of_type ty)
