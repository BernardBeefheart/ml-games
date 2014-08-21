(*
 * continuations.sml
 *
 * Pour calculer la somme d'une liste
 *)

use "c:/cygwin64/home/TATIN_B/ml-games/remember/common.sml";

(* variation 1 : récursion simple *)
fun sum1 [] = 0
  | sum1 (x::t) = x + sum1 t;

(* variation 2 : récursion terminale *)
fun sum2 s =
let
  fun sum [] acc = acc
    | sum (h::t) acc = sum t (acc + h)
in
  sum s 0
end;

(* variation 3 : avec continuation *)
fun sum3 s =
let
  fun sum [] (k:int -> int) = k 0
    | sum (x::t) k = sum t (fn a => k(x + a))
in
  sum s identity
end;

fun gen_sum s f =
let
  fun sum [] (k:int -> int) = k 0
    | sum (h::t) k = sum t (fn a => identity(k(h) + a))
in
  sum s f
end;


