(*
 * lambda.sml
 *)

 signature LAMBDA =
    sig
      val lamb_identity : 'a -> 'a
    end;

structure Lambda : LAMBDA =
    struct
      fn lamb_identity x = x
    end;
