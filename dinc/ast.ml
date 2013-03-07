type expression =
  | Instr of expression list
  | Word of string
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * expression * string option
  | List of expression * expression
  | Sequence of expression * expression
  | Condition of expression * expression * expression
  | Nill
  | Null
  | Variable of string * int
  | Application of expression * expression
  | Primitive of string * expression list

let string_of_ast e =
  let buffer = Buffer.create 16

  in let add_char = Buffer.add_char buffer
  in let add_string = Buffer.add_string buffer

  in let rec aux = function
    | Application (a, b) -> add_char '(';
                            aux a;
                            add_char ' ';
                            aux b;
                            add_char ')';

    | Lambda (a, e, None) ->  add_char '\\';
                              add_char '.';
                              add_string a;
                              add_char ' ';
                              aux e;

    | Lambda (a, e, Some n) -> add_char '\\';
                               add_char '.';
                               add_string n;
                               add_char '.';
                               add_string a;
                               add_char ' ';
                               aux e;

    | Sequence (a, b) ->    add_char '[';
                            aux a;
                            add_char ' ';
                            aux b;
                            add_char ']';

    | Word s ->             add_char '{';
                            add_string s;
                            add_char '}';

    | Character c ->        add_char '\'';
                            add_char c;
                            add_char '\'';

    | Integer i ->          add_string (string_of_int i);

    | Real r ->             add_string (string_of_float r);

    | Boolean b ->          add_string (if b then "true" else "false");

    | List (a, b) ->        add_char '(';
                            aux a;
                            add_string " . ";
                            aux b;
                            add_char ')';

    | Nill ->               add_string "nill";

    | Null ->               add_string "()";

    | Primitive (p, l) ->   let rec f = function
                              | [] -> ()
                              | x :: r -> aux x; if List.length r > 0 then (add_char ' '; f r);
                            in add_char '(';
                               add_string p;
                               if (List.length l > 0) then add_char ' '; f l;
                               add_char ')';

    | Variable (n, i) ->    add_string n

    | Instr l ->            let rec f = function
                              | [] -> ()
                              | x :: r -> aux x; if List.length r > 0 then (add_char ' '; f r);
                            in add_char '(';
                               f l;
                               add_char ')';

    | Condition (i, a, b) ->  add_string "(if ";
                              aux i;
                              add_char ' ';
                              aux a;
                              add_char ' ';
                              aux b;
                              add_char ')';

  in aux e; Buffer.contents buffer
