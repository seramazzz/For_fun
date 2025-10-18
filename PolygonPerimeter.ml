(*
You are given the cartesian coordinates of a set of points in a 2D plane.
When traversed sequentially, these points form a Polygon, which is not self-intersecting in nature.
Can you compute the perimeter of polygon?
*)

let euclidean p1 p2 =
  let x1, y1 = p1 in
  let x2, y2 = p2 in
  sqrt ((float_of_int (x2 - x1)) ** 2. +. (float_of_int (y2 - y1)) ** 2.)
  
(* Instead of List.fold_left ( + ) 0 lst *)
(*
let sum lst =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (acc + h) t
  in
  aux 0 lst
*)

let perimeter pnts =
    match pnts with
    | [] | [_] -> 0.
    | first :: _ -> let rec helper per = function
                        | h1 :: (h2 :: _ as t) -> helper (per +. euclidean h1 h2) t
                        | [last] -> per +. euclidean last first   
                        | [] -> per
                    in
                    helper 0. pnts

let read_points () =
  let n = Scanf.scanf " %d" (fun x -> x) in
  let rec read_pairs k =
    if k = 0 then []
    else
      let a, b = Scanf.scanf " %d %d" (fun x y -> (x, y)) in
      (a, b) :: read_pairs (k - 1)
  in
  read_pairs n

let () =
  let points = read_points () in
  print_float @@ perimeter points
