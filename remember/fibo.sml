(*
 * fibo.sml
 * calcul des nombres de Fibonacci avec memoïzation
 * calcul jusqu'à 46 pour les entiers 32 bits
 *)


open BtIO ShowResults GetArgs;



fun fibo_maker n =
let
  val array_dim = if n > 2
                  then n + 1
                  else 3

  val  fibo_values : IntInf.int option array = Array.array(array_dim, NONE);

  fun get_fibo 0 = 0
    | get_fibo 1 = 1
    | get_fibo k =
    case Array.sub (fibo_values, k)
      of SOME r => r
       | NONE =>
           let
             val f = get_fibo (k - 1) + get_fibo (k - 2);
           in
             Array.update (fibo_values, k, SOME f);
             f
           end
in
  get_fibo
end;


fun main () =
let
  val arg1 = get_fact_arg (CommandLine.arguments ());
  val fbm = fibo_maker arg1;
in
  show_all_int_results "fibo " fbm arg1;
  print ""
end
handle GetArgs.NoArgument => print "We need an argument (positive integer)\n"
  | GetArgs.BadArgument => print "The argument must be a positive integer\n"
  | GetArgs.NegativeArgument => print "The argument must be a positive integer\n";

main();
