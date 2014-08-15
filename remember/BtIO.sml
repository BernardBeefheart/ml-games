(*
 * BtIO.sml
 *)

signature BTIO =
    sig
      val printInt : int -> unit
      val printReal : real -> unit
    end;

structure BtIO: BTIO =
    struct
      fun printInt x = print (Int.toString x)
      fun printReal x = print (Real.toString x)
    end;        

