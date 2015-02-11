(*
 * fibo.fs
 *
 * version FSharp
 * calcul des nombres de Fibonacci avec memoïzation
 *
 * compilation (Windows):
 * Fsc.exe --warn:5 --consolecolors+ --standalone --out:fsfibo.exe --tailcalls+ --optimize+ fibo.fs
 * compilation (PCBSD):
 * fsharpc --warn:5 --consolecolors+ --standalone --out:fsfibo.exe --tailcalls+ --optimize+ fibo.fs
 *
 *)

module fibo

open Constants
open Help

exception NegativeNumber of string


(*
 * memoiseFibo
 * mémoïsation de la suite de fibonacci
 * renvoie la vraie fonction de calcul de fibonacci
 *)
let memoiseFibo n =
    let asize = if n < 3
                then 3
                else n + 1

    let (memo : bigint array) = Array.zeroCreate asize

    (* pour les versions Unix! *)
    let rec resetMemo k =
        if k >= 0
        then memo.[k] <- 0I; resetMemo (k - 1)
        else ()

    let rec get_fibo = function
        | 0 -> 0I
        | 1 -> 1I
        | 2 -> 1I
        | n -> if memo.[n] = 0I
                    then
                        let f = get_fibo (n - 1) + get_fibo (n - 2)
                        memo.[n] <- f
                        f
                    else memo.[n]

    (* pour les versions Unix! *)
    resetMemo (asize - 1)
    get_fibo;;

(*
 * doit
 * boucle principale
 *)
let doit str_numberOfTests =
    try
        let numberOfTests = int str_numberOfTests
        if numberOfTests < 0
            then raise (NegativeNumber ("Error: Negative number!"))
            else printfn ""

        let lafibo = memoiseFibo numberOfTests

        let show_fibo k = printfn "fibo %d = %s" k (string (lafibo k))


        let rec show_all_fibos n =
            if n = numberOfTests
            then show_fibo n
            else show_fibo n; show_all_fibos (n + 1)

        show_all_fibos 0
        0
    with
        | NegativeNumber(str) -> dohelp ExitErrorNegative
        | :? System.FormatException -> dohelp ExitErrorBadArgs
        | _ -> dohelp ExitErrorUnknown;;



[<EntryPoint>]
let main args =
    let onArgs = function
        | 0 -> dohelp ExitSuccess
        | 1 -> doit args.[0]
        | _ -> dohelp ExitErrorTooMuchArgs

    onArgs args.Length;;
