(*
 * TestSig.sml
 *)

(*use "Lambda.sml";
use "BtIO.sml";*)

open Lambda;
open BtIO;


fun test_identity N =
let
  fun onk k x =
  let

    fun show message value value_printer =
    let
      val id = lamb_identity value;
    in
      print message;
      print "(";
      value_printer value;
      print ") = ";
      value_printer id
    end;

  in
    show "idk" k printInt;
    show " idx" x printReal;
    print "\n"
  end;

  fun iloop 0 x = onk 0 x
    | iloop k x =
  let
    val _ = onk k x
  in
    iloop (k - 1) (x + 0.1)
  end;
in
  iloop N 0.0
end;

test_identity 5;
