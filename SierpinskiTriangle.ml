(*
  Sierpiński Triangle (ASCII Fractal)
  -----------------------------------
  The Sierpiński triangle is a famous fractal: a pattern made of smaller
  self-similar triangles nested inside each other. At level 0, we draw
  a single upright triangle of height 32 and width 63. Each recursion
  step (iteration) replaces every upright triangle with 3 smaller ones:
  - one at the top
  - one bottom-left
  - one bottom-right
  leaving a downward-pointing empty triangle in the center.
  
  The output is a 32×63 grid of characters:
  - '1' marks filled cells
  - '_' marks empty cells
*)

(* [fill arr r c h i j]
   Recursively fills an upright triangle of height [h] into the canvas [arr].
   - [arr] is a 32×63 array of mutable rows (Bytes).
   - [r, c] is the position of the top point of the triangle.
   - [h] is the height of the triangle.
   - [i] is the current row offset inside the triangle (0..h-1).
   - [j] is the current index within that row's span of '1's.
   Effect: sets the corresponding cells in [arr] to '1'. *)
let rec fill arr r c h i j =
  if i = h
  then ()
  else if j = 2*i+1
       then fill arr r c h (i+1) 0
       else (Bytes.set (Array.get arr (r+i)) (c-i+j) '1';
          fill arr r c h i (j+1))
  
(* [draw arr n r c h]
    Recursively draws a Sierpiński triangle of iteration [n].
     - [arr] is the canvas.
     - [n] is the iteration depth (0 to 5).
     - [r, c] is the position of the the top point of the triangle.
     - [h] is the height of the triangle.
     If [n=0], we draw a solid triangle using [fill].
     If [n>0], we recursively draw 3 smaller triangles of height h/2:
       - one on top (the top point at [r, c])
       - one bottom-left (the top point at [r+h/2, c-h/2])
       - one bottom-right (the top point at [r+h/2, c+h/2])
*)
let rec draw arr n r c h =
  if n = 0
  then fill arr r c h 0 0
  else (draw arr (n-1) r c (h/2);
        draw arr (n-1) (r+h/2) (c-h/2) (h/2);
        draw arr (n-1) (r+h/2) (c+h/2) (h/2))
  
(* [sierpinski n]
    Creates a 32×63 grid initialized with '_' and draws
    the Sierpiński triangle of iteration [n] into it.
    Returns the result as a single string with newline separators. *)
let sierpinski n =
  let arr = Array.init 32 (fun _ -> Bytes.make 63 '_') in
  draw arr n 0 31 32;
  Array.to_list arr |> List.map Bytes.to_string |> String.concat "\n"
  
(* Running *)
let () =
  read_int () |> sierpinski |> print_string;
  print_newline ()