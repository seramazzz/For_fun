let rec factorial n =
  if n <= 0 then 1 (* we'd expect n >= 0*)
  else n * factorial (n-1)

 let factorial n =
  let rec aux acc n =
    if n <= 0 then acc
     else aux (acc * n) (n - 1)
  in
  aux 1 n
  

let () =
  print_string "Enter number: ";
  let n = read_int () in
  print_string "Factorial of "; print_int (n); print_string " is "; print_int (factorial n);
  print_newline ()