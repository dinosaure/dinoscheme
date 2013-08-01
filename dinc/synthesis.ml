module Et = Map.Make (String)

type t =
  | Primitive of p
  | Type of Type.schema
and p = { f: (t Et.t -> Lambda.t list -> Type.kind); t: Type.kind }

let rec insert e = function
  | [] -> e
  | x :: r -> insert (Et.add x (Type.schema (Type.unknown_type ())) e) r

let lambda e a = function
  | None -> insert e [a]
  | Some n -> insert e [a; n]

let foldl f a l = List.fold_left f a l
let foldr f l a = List.fold_right f l a

let search env n =  try Type.specialization (Et.find n env)
                    with Not_found -> raise (Failure ("Unbound value of " ^ n))

let rec eval env a = match a with
  | Lambda.Boolean b         -> Type.type_boolean
  | Lambda.Integer i         -> Type.type_integer
  | Lambda.Real r            -> Type.type_real
  | Lambda.Character c       -> Type.type_character
  | Lambda.Null              -> Type.type_void
  | Lambda.Nill              -> Type.type_list (Type.unknown_type ())

  | Lambda.Word n            -> search env n

  | Lambda.Lambda (arg, exp, sta) ->
      let env = lambda env arg sta
      in let pr = eval env exp
      in let pa = search env arg
      in let pf = Type.type_arrow pa pr
      in let pc = function
        | None -> pf
        | Some n -> Type.unification pf (search env n); pf
      in pc sta

  | Lambda.List (h, t) ->
      let ph = eval env h in
      let pt = eval env t in
      Type.unification (Type.type_list ph) pt;
      pt

  | Lambda.Tuple l ->
      Type.type_tuple (Array.of_list (List.map (fun x -> eval env x) l))

  | Lambda.Sequence (pa, pb) ->
      let ta = eval env pa and tb = eval env pb
      in Type.unification ta Type.type_void; tb

  | Lambda.Condition (ti, ta, tb) ->
      let pi = eval env ti
      in let pa = eval env ta
      in let pb = eval env tb
      in Type.unification pi Type.type_boolean;
         Type.unification pa pb;
      pa

  | Lambda.Primitive (p, l) ->
      let pr = Type.unknown_type ()
      in let pa = List.map (fun x -> eval env x) l
      in let pf = search env p
      in Type.unification pf (foldr (fun a -> fun b -> Type.type_arrow a b) pa pr);
         pr

  | Lambda.Application (Lambda.Lambda (arg, exp, sta), par) ->
      Type.start_definition ();
      let aux = match sta with
        | None -> eval env par
        | Some n -> let tr = Type.unknown_type () in
      let te = eval (Et.add n (Type.schema tr) env) par
      in Type.unification te tr; te
      in Type.stop_definition ();
         eval (Et.add arg (Type.generalization aux) env) exp

  | Lambda.Application (ta, tb) ->
      let pa = eval env ta in
      let pb = eval env tb in
      let pr = Type.unknown_type () in
      Type.unification pa (Type.type_arrow pb pr); pr
