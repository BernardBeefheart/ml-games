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
    end;

structure BtIO: BTIO =
    struct

      fun printInt x = print (Int.toString x)
      fun printIntInf x = print (IntInf.toString x)
      fun printReal x = print (Real.toString x)

      datatype exitCode = SUCCESS | FAILURE
      fun onError message = 
      let
        val _ = print ("ERROR! " ^ message ^ "\n");
      in
        FAILURE
      end;
    end;        

