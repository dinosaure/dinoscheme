{
  open Parser

  let char_of_backslash = function
    | 'n' -> '\n'
    | 'r' -> '\r'
    | 'b' -> '\b'
    | 't' -> '\t'
    | c -> c

  let char_of_hexa a b =
    let ac = Char.code a in
    let av = if ac >= 97 then ac - 87
             else if ac >= 65 then ac - 55
             else ac - 48
    in 
    let bc = Char.code b in
    let bv = if bc >= 97 then bc - 87
             else if bc >= 65 then bc - 55
             else bc - 48
    in Char.chr (av * 16 + bv)
}

let DIGIT = ['0' - '9']
let HEXA = ['0' - '9' 'a' - 'f' 'A' - 'F']
let ALPHA = ['A' - 'Z' 'a' - 'z']
let ALL   = ALPHA | ['+' '-' '*' '/' '_' '=' '<' '>' '&' '|' '!' '^' '%' '#']
let EMPTY = ['\n' '\t' ' ']

let BACKSLASH = ['\\' '\'' '"' 'n' 't' 'b' 't' ' ']

rule lexer = parse
  | eof                               { EOF }
  | '['                               { RBR }
  | ']'                               { LBR }
  | '('                               { RPA }
  | ')'                               { LPA }
  | EMPTY +                           { lexer lexbuf }
  | "true"                            { Boolean true }
  | "false"                           { Boolean false }
  | "if"                              { IF }
  | "let"                             { LET }
  | "define"                          { DEFINE }
  | "lambda"                          { LAMBDA }
  | "list"                            { LIST }
  | "nill"                            { NILL }
  | "begin"                           { BEGIN }
  | "."                               { DOT }
  | ","                               { COMMA }
  | '-' ? DIGIT + as i                { Integer (int_of_string i) }
  | '-' ? DIGIT + '.' DIGIT + as f    { Real (float_of_string f) }
  | ALL+ as w                         { Word w }
  | '"'                               { let buffer = Buffer.create 16 in String (stringl buffer lexbuf) }
  | "'" '\\' (BACKSLASH as c) "'"     { Character (char_of_backslash c) }
  | "'" '\\' HEXA as a HEXA as b "'"  { Character (char_of_hexa (String.get a 0) (String.get b 0)) }
  | "'" ([^ '\\'] as c) "'"           { Character c } 
  | _                                 { lexer lexbuf }
and stringl buffer = parse
  | '"'                               { Buffer.contents buffer }
  | "\\t"                             { Buffer.add_char buffer '\t'; stringl buffer lexbuf }
  | "\\n"                             { Buffer.add_char buffer '\n'; stringl buffer lexbuf }
  | '\\' '"'                          { Buffer.add_char buffer '"'; stringl buffer lexbuf }
  | '\\' '\\'                         { Buffer.add_char buffer '\\'; stringl buffer lexbuf }
  | _ as c                            { Buffer.add_char buffer c; stringl buffer lexbuf }
