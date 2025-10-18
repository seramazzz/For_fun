(* Compute the greatest common divisor using the Euclidean algorithm*)
let rec gcd x y =
  if x = y then x
  else if x > y then gcd (x-y) y
  else gcd (y-x) x
  
let () =
  let x, y = Scanf.scanf "%d %d" (fun x y -> (x, y)) in
  print_int (gcd x y); print_newline ()