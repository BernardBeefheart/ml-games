(*
 * BtIO.sml
 *)

signature BTIO =
    sig
      datatype exitCode = SUCCESS | FAILURE

      val printInt : int -> unit
      val printIntInf : IntInf.int -> unit
      val printReal : real -> unit

      val onError : string -> exitCode

      val printLn : string list -> unit
    end;

structure BtIO: BTIO =
    struct
      datatype exitCode = SUCCESS | FAILURE

      fun printLn [] = print "\n"
        | printLn (h :: t) = (
        print h;
        printLn t
        );

      fun printInt x = print (Int.toString x)
      fun printIntInf x = print (IntInf.toString x)
      fun printReal x = print (Real.toString x)

        

      fun onError message = 
      let
        val _ = print ("ERROR! " ^ message ^ "\n");
      in
        FAILURE
      end;
    end;        

