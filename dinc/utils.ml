let string_of prefix counter () =
  let name = (String.make 1 (char_of_int (int_of_char 'a' + (!counter mod 26)))) ^
             (if !counter >= 26 then (string_of_int (!counter / 26)) else "")
  in incr counter; prefix ^ name
