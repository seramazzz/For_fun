let rec fib n =
  if n <= 1 then n
  else fib (n - 1) + fib (n - 2)

let () =
  let fib_n = fib 3 in
  print_int (fib_n); print_newline ()
