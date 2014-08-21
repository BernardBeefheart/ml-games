(*
 * common.sml
 *)


(*
* affiche un entier sur la console
*)
fun printVal x = print (IntInf.toString x);

datatype result_type = SUCCESS | ERROR;

fun on_error message =
let
  val _ = print ("ERROR : " ^ message ^ "\n");
in
  ERROR
end;

fun identity x = x;
