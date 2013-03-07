module Sv = Make.Set (Int)

type lambda_exp = 
  | Character of char
  | Integer of int
  | Real of float
  | Boolean of bool 
  | Lambda of string * lambda_exp
  | Null
  | Variable of string * int
  | Application of lambda_exp * lambda_exp

type closure_exp =
  | Lambda of string * closure_exp
  | Closure of closure_exp * closure_exp
  | Environment of (int * closure_exp) list
  | Get of closure_exp * string * int
  | Application of closure_exp * closure_exp

let subtract a b = Sv.filter  

let rec free = function
  | Lambda (argument, expression) ->
      set_subtract (free expression) 
