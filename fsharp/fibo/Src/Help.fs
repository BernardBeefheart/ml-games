(*
 * Help.fs
 * affichage de l'aide
 *)

module Help

open Constants

(*
 * dohelp :
 * affiche un texte d'aide et retourne son paramètre
 *)
let dohelp exitValue =

    let firstMessage = function
        | Constants.ExitSuccess -> ""
        | Constants.ExitErrorBadArgs -> "ERROR : Bad typed argument\n"
        | Constants.ExitErrorTooMuchArgs -> "ERROR : Too much arguments\n"
        | Constants.ExitErrorNegative -> "ERROR : Negative argument\n"
        | _ -> "ERROR : Unknown error\n"

    eprintf "%s" (firstMessage exitValue)
    printfn "Usage:"
    printfn "   fibo.exe Number"
    printfn "   where Number is a positive integer"
    exitValue;;
