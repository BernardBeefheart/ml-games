(*
 * fibo.sml
 * calcul des nombres de Fibonacci avec memoïzation
 * calcul jusqu'à 46 pour les entiers 32 bits
 *)


open BtIO;

val ARRAY_SIZE : int = 20000;

fun fibo_maker() =
let
  val  fibo_values : IntInf.int option array = Array.array(ARRAY_SIZE, NONE);

  val _ = Array.update(fibo_values, 0, SOME 0)
  val _ = Array.update(fibo_values, 1, SOME 1);
  val _ = Array.update(fibo_values, 2, SOME 2);

  fun get_fibo 1 = 1
    | get_fibo 2 = 1
    | get_fibo k =
    if k < ARRAY_SIZE
    then
        case Array.sub (fibo_values, k)
          of SOME r => r
           | NONE =>
               let
                 val f = get_fibo (k - 1) + get_fibo (k - 2);
               in
                 Array.update (fibo_values, k, SOME f);
                 f
               end
    else
      0
in
  get_fibo
end;

fun main () =
let
  val args = CommandLine.arguments ();
  val default_value:Int.int = 10;
  
  fun get_undefined () = 
  let
    val m = default_value;
  in
    m
  end;

  fun get_fact_arg [] = default_value
    | get_fact_arg (h::t) = 
    case (Int.fromString h)
      of NONE => get_undefined ()
       | SOME m => m;

  val arg1 = get_fact_arg (args);

  val fbm = fibo_maker();

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
    show_all_fibos arg1
end;

main();
