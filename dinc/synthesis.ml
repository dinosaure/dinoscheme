module Et = Map.Make (String)

type t =
  | Primitive of p
  | Type of Type.schematype
and p = { f: (t Et.t -> Ast.expression list -> Type.simpletype); t: Type.simpletype }

let rec insert e = function
  | [] -> e
  | x :: r -> insert (Et.add x (Type.schema (Type.unknowntype ())) e) r

let lambda e a = function
  | None -> insert e [a]
  | Some n -> insert e [a; n]

let foldl f a l = List.fold_left f a l
let foldr f l a = List.fold_right f l a

let unification tt ta tb = let t = Ast.string_of_ast tt in
                           try Type.unification ta tb 
                           with Failure s ->          Printf.printf "type: %s in %s" s t;
                                                      print_newline (); 
                                                      exit 0
                              | Type.Conflict a ->    Printf.printf "type: %s in %s" (Type.conflict a) t; 
                                                      print_newline ();
                                                      exit 0
                              | Type.Circularity a -> Printf.printf "type: %s in %s" (Type.circularity a) t;
                                                      print_newline ();
                                                      exit 0

let rec eval env a = match a with
  | Ast.Boolean b         -> Type.tboolean
  | Ast.Integer i         -> Type.tinteger
  | Ast.Real r            -> Type.treal
  | Ast.Character c       -> Type.tcharacter
  | Ast.Null              -> Type.tvoid
  | Ast.Nill              -> Type.tlist (Type.unknowntype ())

  | Ast.Word n
  | Ast.Variable (n, _)   -> (try Type.specialization (Et.find n env)
                              with Not_found -> raise (Failure ("Unbound value of " ^ n)))

  | Ast.Lambda (arg, exp, sta) -> let env = lambda env arg sta
                                  in let pr = eval env exp
                                  in let pa = eval env (Ast.Word arg)
                                  in let pf = Type.tarrow pa pr
                                  in let pc = function
                                    | None -> pf
                                    | Some n -> unification a pf (eval env (Ast.Word n)); pf
                                  in pc sta

  | Ast.List (h, t) -> let ph = eval env h in
                       let pt = eval env t in
                       unification a (Type.tlist ph) pt;
                       pt

  | Ast.Sequence (pa, pb) -> let ta = eval env pa and tb = eval env pb
                             in unification a ta Type.tvoid; tb

  | Ast.Condition (ti, ta, tb) -> let pi = eval env ti
                                  in let pa = eval env ta
                                  in let pb = eval env tb
                                  in unification a pi Type.tboolean;
                                    unification a pa pb;
                                    pa

  | Ast.Primitive (p, l) -> let pr = Type.unknowntype ()
                            in let pa = List.map (fun x -> eval env x) l
                            in let pf = eval env (Ast.Word p)
                            in unification a pf (foldr (fun a -> fun b -> Type.tarrow a b) pa pr);
                               pr

  | Ast.Application (Ast.Lambda (arg, exp, sta), b) -> Type.start_definition ();
                                                       let aux = match sta with
                                                         | None -> eval env b
                                                         | Some n -> let tr = Type.unknowntype () in
                                                                     let te = eval (Et.add n (Type.schema tr) env) b
                                                                     in unification a te tr; te
                                                       in Type.stop_definition ();
                                                          eval (Et.add arg (Type.generalization aux) env) exp

  | Ast.Application (ta, tb) -> let pa = eval env ta in
                                let pb = eval env tb in
                                let pr = Type.unknowntype () in
                                unification a pa (Type.tarrow pb pr); pr

  | a -> raise (Failure ("synthesis: unbound element " ^ Ast.string_of_ast a))
