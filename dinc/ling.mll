{
  open Ping
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
  | "define"                          { DEFINE }
  | "apply"                           { APPLY }
  | "type"                            { TYPE }
  | "integer"                         { T_INTEGER }
  | "real"                            { T_REAL }
  | "boolean"                         { T_BOOLEAN }
  | "character"                       { T_CHARACTER }
  | "void"                            { T_VOID }
  | "list"                            { T_LIST }
  | "->"                              { T_ARROW }
  | ","                               { T_TUPLE }
  | DIGIT + as i                      { Integer (int_of_string i) }
  | '#' (HEXA + as i)                 { Integer (Util.int_of_hexa_string i) }
  | ALL+ as w                         { Word w }
