(*
 * Help.fs
 * affichage de l'aide, avec un message d'erreur si nécessaire
 *)

module Help

open Constants

(*
 * dohelp exitValue
 * affiche un texte d'aide et retourne son paramètre
 * exitValue :  code de sortie du programme. Si exitValue n'est
 *      pas nul, un message est envoyé sur la console d'erreur
 *      en fonction de la valeur de ExitValue
 * return: le paramètre exitValue
 *)
let dohelp exitValue =

    let firstMessage = function
        | Constants.ExitSuccess -> ""
        | Constants.ExitErrorBadArgs -> "ERROR : Bad typed argument\n"
        | Constants.ExitErrorTooMuchArgs -> "ERROR : Too much arguments\n"
        | Constants.ExitErrorNegative -> "ERROR : Negative argument\n"
        | _ -> "ERROR : Unknown error\n"

    if exitValue <> ExitSuccess then eprintf "%s" (firstMessage exitValue)
    printfn "Usage:"
    printfn "   fibo.exe Number"
    printfn "   where Number is a positive integer"
    exitValue;;
