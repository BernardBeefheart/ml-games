(*
* remember.ml
* se souvenir des bases de ML
*)
exception Negative;

fun on_error message = 
let 
  val _ = print ("ERROR : " ^ message ^ "\n"); 
in  
  1
end;

(* 
* cette factorielle illustre bien
* l'utilisation de fonctions imbriquées permettant
* la récursion terminale.
*
* Le typage du paramètre nous assure de l'utilisation des bignumbers avec mlton
* et ne change rien avec PolyML
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
* Et on lance une exception en cas de valeur négative de l'argument.
*)
fun fact2 n:IntInf.int =
let
  fun inner_fact (acc, 0) = acc
    | inner_fact (acc, k) = inner_fact (acc * k, k - 1);
in
  if n < 0 
  then raise Negative
  else inner_fact (1, n)
end;

(*
* affiche un entier sur la console
*)
fun printVal x = print (IntInf.toString x);



fun test_f (f, arg, fname) =
let
  val result = IntInf.toString (f arg);
in    
  print (fname);
  print (" ");
  printVal (arg);
  print (" -> ");
  print (result);
  print ("\n");
  0
end;  

fun test_f_on_n (f, fname, 0) = test_f (f, 0, fname)
  | test_f_on_n (f, fname, k) =
  let
    val km = k - 1;
in  
  test_f (f, k, fname);
  test_f_on_n (f, fname, km);
  0
end;    


fun main () = 
let
  val args = CommandLine.arguments ();
  val default_value:IntInf.int = 10;

  fun get_undefined () = 
  let
    val m = default_value;
  in
    m
  end;

  fun get_fact_arg [] = default_value
    | get_fact_arg (h::t) = 
    case (IntInf.fromString h)
      of NONE => get_undefined ()
       | SOME m => m;

  val arg1 = get_fact_arg (args);

  val retval = test_f_on_n (fact2, "!", arg1)
      handle Negative => on_error "Negative value";
in  
  retval
end;

main ();
