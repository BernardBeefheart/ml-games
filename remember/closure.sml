(*
 * closure.sml
 * les fermetures en SML
 * dont une partie sans docs, internet cass?!
 *)

 (*
  * constantes, une sorte d'enum
  *)
datatype cpt_actions = cpt_reset | cpt_inc | cpt_dec | cpt_get;

(*
 * make_compteur (start, inc) :
 * renvoie une fermeture g?rant un compteur
 * - valeur de d?part : start,
 * - valeur d'incr?ment/d?cr?ment : inc
 *
 * La fermeture accepte pour param?tre une des constantes cpt_xxx
 * d?finies plus haut.
 * - cpt_reset : remet le compteur ? la valeur start,
 * - cpt_inc : incr?mente le compteur de la valeur inc,
 * - cpt_dec : d?cr?mente le compteur de la valeur inc.
 *)
fun make_compteur (start, inc) =
let
  (* le compteur *)
  val inner_cpt : int ref = ref start;

  (* la fermeture retourn?e *)
  fun compteur (action) =
  let

    (* ex?cution de l'action *)
    fun icompteur cpt_reset =
        let
          val _ = inner_cpt := start;
        in
          !inner_cpt
        end
      | icompteur cpt_inc =
        let
          val _ = inner_cpt := !inner_cpt + inc;
        in
          !inner_cpt
        end
      | icompteur cpt_dec =
        let
          val _ = inner_cpt := !inner_cpt - inc;
        in
          !inner_cpt
        end
      | icompteur cpt_get = !inner_cpt;

  in
    icompteur action
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
  printVal (r)
end;

val c1 = make_compteur(0, 1);
val c2 = make_compteur(20, 3);
fun test_n n =
let

  fun dotest () =
  let
    val _ = c2(cpt_inc);
  in
    test (c1(cpt_dec), " v1");
    test (c2(cpt_get), " v2");
    print ("\n")
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

test_n 5;
c1 cpt_reset;
test_n 7;
