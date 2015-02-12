(*
 * DoFibo.fs
 * calcul et affichage des nombres de Fibonacchi
 *)

module DoFibo

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

    let rec get_fibo = function
        | 0 -> 0I
        | 1 -> 1I
        | n -> if memo.[n] = 0I
                    then
                        let f = get_fibo (n - 1) + get_fibo (n - 2)
                        memo.[n] <- f
                        f
                    else memo.[n]

    get_fibo;;

(*
 * doFibo
 * boucle principale
 *)
let doFibo (str_numberOfTests:string) : int =
    try
        let numberOfTests = int str_numberOfTests
        if numberOfTests < 0
            then raise (NegativeNumber ("Error: Negative number!"))
            else printfn ""

        let lafibo = memoiseFibo numberOfTests

        let show_fibo k = printfn "fibo %d -> %s" k (string (lafibo k))

        let rec show_all_fibos n =
            show_fibo n
            if n <> numberOfTests then show_all_fibos (n + 1)

        show_all_fibos 0
        0
    with
        | NegativeNumber(str) -> dohelp ExitErrorNegative
        | :? System.FormatException -> dohelp ExitErrorBadArgs
        | _ -> dohelp ExitErrorUnknown;;

