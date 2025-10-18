(*
You are given the cartesian coordinates of a set of points in a 2D plane.
When traversed sequentially, these points form a Polygon, which is not self-intersecting in nature.
Can you compute the area of polygon?
*)

(*
Here I use Gauss's area formula (aka shoelace formula):
area = 0.5 * abs [ 
                    (x_1*y_2 + x_2*y_3 + ... x_{n-1}*y_n + x_n*y_1) 
                   -
                     (x_2*y_1 + x_3*y_2 + ... x_n*y_{n-1} + x_1*y_n) 
                 ]
*)

let area pnts =
  match pnts with
  | [] | [_] -> 0.0
  | (xf,yf) :: rest -> let rec helper term1 term2 = function
                          | (x1,y1) :: ((x2,y2) :: _ as t) -> helper (term1 + x1 * y2) (term2 + x2 * y1) t
                          | [(xl,yl)] -> 0.5 *. abs_float (float_of_int (term1 + xl * yf - (term2 + yl * xf)))
                          | _ -> 0.0
                       in helper 0 0 ((xf,yf) :: rest)

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
print_float @@ area points