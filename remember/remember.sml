(*
* remember.ml
* se souvenir des bases de ML
*)

open BtIO ShowResults GetArgs;



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
fun fact2 n =
let
  fun inner_fact (acc, 0) = acc
    | inner_fact (acc, k) = inner_fact (acc * k, k - 1);
in
  if n < 0
  then raise GetArgs.Negative
  else inner_fact (1, n)
end;



fun test_f (f, arg, fname) =
let
  val result = IntInf.toString (f arg);
in
  print (fname);
  print (" ");
  printIntInf (arg);
  print (" -> ");
  print (result);
  print ("\n");
  SUCCESS
end;

fun test_f_on_n (f, fname, 0) = test_f (f, 0, fname)
  | test_f_on_n (f, fname, k) =
  let
    val km = k - 1;
in
  test_f (f, k, fname);
  test_f_on_n (f, fname, km);
  SUCCESS
end;


fun main () =
let
  val arg1 = get_fact_arg (CommandLine.arguments ());

  val retval = test_f_on_n (fact2, "!", arg1)
  handle GetArgs.NoArgument => print "We need an argument (positive integer)\n"
    | GetArgs.BadArgument => print "The argument must be a positive integer\n"
    | GetArgs.NegativeArgument => print "The argument must be a positive integer\n";
  in
    retval
  end;

  main ();
