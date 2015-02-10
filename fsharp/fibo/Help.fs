(*
 * Help.fs
 *)

module Help

open Constants

(*
 * dohelp :
 * affiche un texte d'aide et retourne son paramètre
 *)
let dohelp exitValue =
    let firstMessage = function
        | Constants.ExitSuccess -> "--"
        | Constants.ExitErrorBadArgs -> "ERROR : Bad typed argument"
        | Constants.ExitErrorTooMuchArgs -> "ERROR : Too much arguments"
        | Constants.ExitErrorNegative -> "ERROR : Negative argument"
        | _ -> "ERROR : Unknown error"

    printfn "%s" (firstMessage exitValue)
    printfn "Usage:"
    printfn "   fibo.exe Number"
    printfn "   where Number is a positive integer"
    exitValue;;
