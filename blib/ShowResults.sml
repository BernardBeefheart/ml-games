(*
 * ShowResults.sml
 *)

signature SHOWRESULTS =
sig
  val show_all_int_results: string -> (int -> IntInf.int) -> int -> unit
end;

structure ShowResults: SHOWRESULTS =
struct
  fun show_all_int_results message function n =
  let
    fun show_function k = 
    let
      val f = function k;
    in
      print message;
      BtIO.printInt k;
      print " = ";
      BtIO.printIntInf f;
      print "\n"
    end;

    fun show_all_functions 0 = show_function 0
      | show_all_functions n = (
      show_function n;
      show_all_functions (n - 1)
      );
  in
    show_all_functions n
  end;
end;
