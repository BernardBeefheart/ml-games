(*
 * remember.ml
 * se souvenir des bases de ML
 *)

(* 
 * cette factorielle illustre bien
 * l'utilisation de fonctions imbriquées permettant
 * la récursion terminale.
 *)
fun fact n =
let
    fun inner_fact (acc, k) =
        if k = 0
        then acc    
        else inner_fact (acc * k, k - 1);
in
    inner_fact (1, n)
end;

