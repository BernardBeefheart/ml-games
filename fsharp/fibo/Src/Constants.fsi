(*
 * Constants.fsi
 *)

module Constants
    [<Literal>]
    val ExitSuccess : int = 0;;

    [<LiteralAttribute ()>]
    val ExitErrorNegative : int = 1;;

    [<LiteralAttribute ()>]
    val ExitErrorBadArgs : int = 2;;

    [<LiteralAttribute ()>]
    val ExitErrorTooMuchArgs : int = 9;;

    [<LiteralAttribute ()>]
    val ExitErrorUnknown : int = 254;;

