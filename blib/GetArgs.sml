(*
 * GetArgs.sml
 *)

signature GETARGS =
sig
  exception BadArgument;
  exception NegativeArgument;
  exception NoArgument;

  val get_fact_arg: string list -> int
end;

structure GetArgs: GETARGS =
struct
  exception BadArgument;
  exception NegativeArgument;
  exception NoArgument;

  fun get_fact_arg [] = raise NoArgument
    | get_fact_arg (h::t) = 
    case (Int.fromString h)
      of NONE => raise BadArgument
       | SOME m => if m > 0
                   then m
                   else raise NegativeArgument;
end;
