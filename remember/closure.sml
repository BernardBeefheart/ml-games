(*
 * closure.sml
 * les fermetures en SML
 *)

fun make_compteur () =
let
  val inner_cpt : int ref = ref 0;
  val increment : int ref = ref 1;
  fun compteur () =
  let 
    val _ = inner_cpt := !inner_cpt + 1;
  in
    !inner_cpt
  end

in
  compteur
end;


fun printVal x = print (Int.toString x);

fun test (c, name) = 
let
  val r = c;
in
  print (name);
  print (" = ");
  printVal (r);
  print ("\n")
end;

fun test_n n = 
let
  val c1 = make_compteur();
  val c2 = make_compteur();

  fun dotest () =
  let 
    val v1 = c1();
    val v2 = c2();
    val v2 = c2();
  in
    test (v1, "v1");
    test (v2, "v2")
  end;

  fun iloop 0 = dotest ()
    | iloop k =
    let
      val km = k - 1;
    in
      dotest();
      iloop km
    end;

in
  iloop n
end;
