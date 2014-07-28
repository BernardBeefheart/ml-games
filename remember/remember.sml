(*
 * remember.ml
 * se souvenir des bases de ML
 *)
exception Undefined;

(* 
 * cette factorielle illustre bien
 * l'utilisation de fonctions imbriquées permettant
 * la récursion terminale.
 *)
fun fact n:IntInf.int =
let
  fun inner_fact (acc, k) =
    if k = 0
    then acc    
    else inner_fact (acc * k, k - 1);
in
  inner_fact (1, n)
end;


(* 
 * Cette factorielle illustre bien
 * l'utilisation de fonctions imbriquées permettant
 * la récursion terminale.
 * En plus, on utilise la définition d'une fonction avec les filtres.
 *)
fun fact2 n:IntInf.int =
let
  fun inner_fact (acc, 0) = acc
    | inner_fact (acc, k) = inner_fact (acc * k, k - 1);
in
  inner_fact (1, n)
end;

fun printVal x = print (IntInf.toString x);

fun test_f (f, arg, fname) =
let
  val result = f arg;      
in    
  print (fname);
  print (" ");
  printVal (arg);
  print (" -> ");
  printVal (result);
  print ("\n")
end;  

fun test_f_on_n (f, fname, 0) = test_f (f, 0, fname)
  | test_f_on_n (f, fname, k) =
  let
    val km = k - 1;
in  
  test_f (f, k, fname);
  test_f_on_n (f, fname, km)
end;    

val default_value:IntInf.int = 10;

fun get_undifined () = 
let
  val m = default_value;
in
  m
end;

fun get_fact_arg [] = default_value
  | get_fact_arg (h::t) = 
  case (IntInf.fromString h)
    of NONE => get_undifined ()
     | SOME m => m;
(*
 * val args = CommandLine.arguments ()
 *)
fun main () = 
let
  val args = CommandLine.arguments ();
  val arg1 = get_fact_arg (args);
in  
  test_f_on_n (fact2, "!", arg1)
end;

main ();
