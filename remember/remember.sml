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
signature FACT =
sig
  val fact2: int -> IntInf.int
  val inner_fact: IntInf.int -> int -> IntInf.int
end;

structure Fact: FACT =
struct
  fun inner_fact acc 0 = acc
    | inner_fact acc k = inner_fact (acc * k) (k - 1);

  fun fact2 n =
    if n < 0
    then raise GetArgs.NegativeArgument
    else inner_fact (IntInf.toLarge 1) n;
end;

fun main () =
let
  val arg1 = get_fact_arg (CommandLine.arguments ());
in
  show_all_int_results "fact " Fact.fact2 arg1;
  print ""
end
handle GetArgs.NoArgument => print "We need an argument (positive integer)\n"
  | GetArgs.BadArgument => print "The argument must be a positive integer\n"
  | GetArgs.NegativeArgument => print "The argument must be a positive integer\n";

main();
