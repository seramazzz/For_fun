(*
For a given integer K, print the first K rows of Pascal's Triangle.
The value at the Nth row and Mth column of the triangle is equal to \binom{n}{m}
Indexing starts with 0...
*)
let rec factorial x =
  if x = 1 then 1
  else x-1 |> factorial |> ( * ) x (* x * factorial (x - 1) *)

  let binom n m =
    if m = 0 || n = m then 1
    else factorial n / (factorial m * factorial (n - m))
  
let pascal k =
  for i = 0 to k-1 do
      print_int (binom (k-1) i);
      print_string " ";
  done  

let ()=
  let k = read_int () in
  for i = 1 to k do
      pascal i;   print_newline ()
  done