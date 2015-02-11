(*
 * Constants.fsi
 *)

module Constants

[<Literal>]
val ExitSuccess : int = 0;;

[<Literal>]
val ExitErrorNegative : int = 1;;

[<Literal>]
val ExitErrorBadArgs : int = 2;;

[<LiteralAttribute ()>]
val ExitErrorTooMuchArgs : int = 9;;

[<LiteralAttribute ()>]
val ExitErrorUnknown : int = 254;;


