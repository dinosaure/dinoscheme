type kind =
  | Variable of name
  | Word of string * kind array
and value =
  | Unknown
  | Known of kind
and name =
  { mutable level: int; mutable value: value }
and schema =
  { parameters: name list; content: kind }

type short_kind =
  | Short_variable of string
  | Short_word of string * short_kind array
and short_schema = (string list * short_kind)

exception Circularity of (kind * kind)
exception Conflict of (kind * kind)

let type_integer      = Word ("integer",    [||])
let type_boolean      = Word ("boolean",    [||])
let type_real         = Word ("real",       [||])
let type_character    = Word ("character",  [||])
let type_arrow a b    = Word ("->",         [|a; b|])
let type_list t       = Word ("list",       [|t|])
let type_tuple e      = Word ("*",          e)
let type_void         = Word ("void",       [||])

let short_kind name schemas =
  let merge_name l1 l2 =
    let rec aux a = function
      | [] -> a
      | x :: r ->
        if List.mem x a
        then aux a r
        else aux (x :: a) r
    in aux l1 l2
  in let map = Array.fold_left (fun a (l, _) -> merge_name a l) [] schemas
  in (map, Short_word (name, (Array.map (fun (n, k) -> k) schemas)))

let short_variable name = ([name], Short_variable name )

let l = ref 0

let unknown_type () = Variable { level = !l; value = Unknown }

let start_definition () = incr l
let stop_definition () = decr l

let rec value_of = function
  | Variable ({value = Known ty} as var) ->
    let value_of_type = value_of ty in 
    var.value <- Known value_of_type;
    value_of_type
  | ty -> ty

let rec set_level m ty = match value_of ty with 
  | Variable var -> if var.level > m then var.level <- m
  | Word (w, a) -> Array.iter (set_level m) a

let name_of_variables = ref ([] : (name * string) list)
and c = ref 0

let string_of_variable var =
  try
    (List.assq var !name_of_variables)
  with Not_found -> let name =
    (String.make 1 (char_of_int (int_of_char 'a' + (!c mod 26)))) ^
    (if !c >= 26 then (string_of_int (!c / 26)) else "")
  in incr c;
    name_of_variables := (var, name) :: !name_of_variables;
    name

let rec string_of_type ty = match value_of ty with
  | Variable var -> string_of_variable var
  | Word (w, a) ->
      let b = Buffer.create 16
      in let f w a b = match Array.length a with
        | 0 -> Buffer.add_string b w
        | 1 -> Buffer.add_string b (string_of_type a.(0));
          Buffer.add_char b ' ';
          Buffer.add_string b w
        | _ -> let s w a b =
          Buffer.add_char b '(';
          for i = 0 to Array.length a - 1 do
            Buffer.add_string b (string_of_type a.(i));
            if i + 1 < Array.length a
            then begin Buffer.add_char b ' ';
              Buffer.add_string b w;
              Buffer.add_char b ' ';
            end;
          done;
          Buffer.add_char b ')'
        in s w a b in f w a b;
          Buffer.contents b

let circularity (ta, tb) = "circularity between " ^ string_of_type ta ^
  " and " ^ string_of_type tb
let conflict (ta, tb) = "conflict between " ^ string_of_type ta ^
  " and " ^ string_of_type tb

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
      set_level var.level ty;
      var.value <- Known ty;
    | ty, Variable var -> has_name var ty;
      set_level var.level ty;
      var.value <- Known ty;
    | Word (w1, a1), Word (w2, a2) ->
      if w1 <> w2 then
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
      | Variable var ->
        if (var.level > !l && m == true || m == false) &&
          (List.memq var !parameters) == false
        then parameters := var :: !parameters
      | Word (w, a) -> Array.iter find_parameters a 
  in find_parameters ty; { parameters = !parameters; content = ty }

let generalization ty = generate_schema ty true

let specialization schema = 
  match schema.parameters with 
    | [] -> schema.content
    | parameters -> let new_unknown =
        List.map (fun var -> (var, unknown_type ())) parameters
      in let rec copy ty = match value_of ty with
        | Variable var as ty -> (try List.assq var new_unknown with Not_found -> ty)
        | Word (w, a) -> Word (w, Array.map copy a)
      in copy schema.content

let schema ty = { parameters = []; content = ty }
let primitive ty = generate_schema ty false

let kind_from_short_kind (name, kind) =
  let rec aux map = function
    | Short_variable i -> List.assoc i map
    | Short_word (i, e) -> Word (i, Array.map (fun x -> aux map x) e)
  in let new_name = List.map (fun _ -> unknown_type ()) name
  in let new_kind = aux (List.combine name new_name) kind
  in primitive new_kind

let print_type ty =
  name_of_variables := [];
  c := 0; 
  print_string (string_of_type ty)
