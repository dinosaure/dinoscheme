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

let int_of_hexa_string s =
  let char_of_hexa a =
    let cc = Char.code a in
    if cc >= 97 then cc - 87
    else if cc >= 65 then cc - 55
    else cc - 48
  in let rec aux a s = function
    | 0 -> a + (char_of_hexa (String.get s ((String.length s) - 1)))
    | n ->
      aux ((a + (char_of_hexa (String.get s ((String.length s) - n)))) * 16)
      s (n - 1)
  in (aux 0 s (String.length s)) / 16
