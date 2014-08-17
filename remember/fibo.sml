(*
 * fibo.sml
 * calcul des nombres de Fibonacci avec memoïzation
 * calcul jusqu'à 46 pour les entiers 32 bits
 *)


open BtIO;

exception BadArgument;
exception NegativeArgument;
exception NoArgument;

fun fibo_maker n =
let
  val  fibo_values : IntInf.int option array = Array.array(n+1, NONE);

  val _ = Array.update(fibo_values, 0, SOME 0)
  val _ = Array.update(fibo_values, 1, SOME 1);
  val _ = Array.update(fibo_values, 2, SOME 2);

  fun get_fibo 1 = 1
    | get_fibo 2 = 1
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

fun get_fact_arg [] = raise NoArgument
  | get_fact_arg (h::t) = 
  case (Int.fromString h)
    of NONE => raise BadArgument
     | SOME m => if m > 0
                 then m
                 else raise NegativeArgument;

fun main () =
let
  val args = CommandLine.arguments ();
  val default_value:Int.int = 10;


  val arg1 = get_fact_arg (args);

  val fbm = fibo_maker(arg1);

  fun show_fibo k = 
  let
    val f = fbm k;
  in
    print "fibo ";
    printInt k;
    print " = ";
    printIntInf f;
    print "\n"
  end;

  fun show_all_fibos 1 = show_fibo 1
    | show_all_fibos n = 
    let
      val _ = show_fibo n;
  in
    show_all_fibos (n - 1)
  end;

in
  show_all_fibos arg1;
  print ""
end
handle NoArgument => print "We need an argument (positive integer)\n"
  | BadArgument => print "The argument must be a positive integer\n"
  | NegativeArgument => print "The argument must be a positive integer\n";

main();
