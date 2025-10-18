let power x n =
  let rec helper prod count limit =
      if count < limit then helper (prod *. x) (count + 1) limit else prod
  in
      let absn = if n < 0 then -n else n in
          let res = helper 1.0 0 absn in
              if n < 0 
              then 1.0 /. res
              else res


type pol = float list * float list

let reverse lst =
let rec helper rev = function
  | [] -> rev
  | h :: t -> helper (h :: rev) t
  in
  helper [] lst

let polynomial poly x =
  let rec helper eval x = function
      | ([], []) -> eval
      | (h_coef :: t_coef, h_ord :: t_ord) -> 
          helper (eval +. h_coef *. (power x (int_of_float h_ord))) x (t_coef, t_ord)
      | _ -> eval (* silence the warning *)
  in helper 0. x poly
  
let linspace l r step =
  let rec helper lst x =
      if x > r then reverse lst
      else helper (x :: lst) (x +. step)
  in
  helper [] l
  
let map f lst =
let rec helper acc = function
  | [] -> reverse acc
  | h :: t -> helper (f h :: acc) t
in
helper [] lst
                  
let integration l r step poly =
  linspace l r step |> map (fun x -> (polynomial poly x) *. step)
  
let volume l r step poly =
  linspace l r step |> map (fun x -> (power (polynomial poly x) 2) *. step)
  
let pi depth =
  let rec helper acc k =
      if k >= depth
      then acc
      else let term = 4.0 *. (power (-1.0) k) /. (2.0 *. float_of_int k +. 1.0) 
           in helper (acc +. term) (k + 1)
  in
  helper 0.0 0

let sum_list lst =
  let rec helper s = function
      | [] -> s
      | h :: t -> helper (s +. h) t
  in helper 0. lst
  
let read_floats () =
  read_line ()
  |> String.split_on_char ' '
  |> List.filter (fun s -> s <> "")
  |> List.map float_of_string

let read_ints () =
  read_line ()
  |> String.split_on_char ' '
  |> List.filter (fun s -> s <> "")
  |> List.map int_of_string

let () =
  let a = read_floats () in
  let b = read_floats () in
  let lr = read_floats () in
  let l = List.nth lr 0 in
  let r = List.nth lr 1 in
  let p : pol = (a, b) in
  let vals = integration l r 0.001 p in
  let vals_vol = volume l r 0.001 p in

  let area = sum_list vals in
  let volume_solid = (pi 1000) *. sum_list vals_vol in
  
  print_float area;
  print_newline ();
  print_float volume_solid;

  (* Or Simpler *)
  (*
  type pol = float list * float list

let polynomial (a, b) x =
  List.fold_left2 (fun acc c e -> acc +. c *. (x ** e)) 0.0 a b

let linspace l r step =
  let n = int_of_float (floor ((r -. l) /. step)) in
  List.init (n + 1) (fun k -> l +. float_of_int k *. step)

(* read a line of floats *)
let read_floats () =
  read_line ()
  |> String.split_on_char ' '
  |> List.filter (fun s -> s <> "")
  |> List.map float_of_string

let () =
  let a = read_floats () in          (* coefficients *)
  let b = read_floats () in          (* exponents *)
  let lr = read_floats () in
  let l = List.nth lr 0 and r = List.nth lr 1 in
  let p : pol = (a, b) in

  let step = 0.001 in
  let xs = linspace l r step in

  let area =
    xs
    |> List.map (fun x -> polynomial p x *. step)
    |> List.fold_left ( +. ) 0.0
  in

  let volume =
    xs
    |> List.map (fun x -> (polynomial p x ** 2.) *. step)
    |> List.fold_left ( +. ) 0.0
    |> fun s -> Float.pi *. s
  in

  Printf.printf "%.1f\n%.1f\n" area volume

  *)