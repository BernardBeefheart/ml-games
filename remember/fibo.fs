(*
 * fibo.fs
 * version FSharp
 * calcul des nombres de Fibonacci avec memoïzation
 * 
 * compilation (PCBSD):
 * fsharpc --warn:5 --consolecolors+ --standalone --out:fsfibo.exe --tailcalls+ --optimize+ fibo.fs
 *
 * valeur maximale du paramètre acceptable sans erreur : 15361
 * problème de pile? de taille de tableau? dépassement de capacité
 * des bigint?
 *
 *)

module fibo

(*
 * dohelp :
 * affiche un texte d'aide et retourne son paramètre
 *)
let dohelp exitValue =
    printfn "Usage:"
    printfn "   fibo.exe Number"
    exitValue;;

(*
 * mfibo
 * mémoïsation de la suite de fibonacci
 * renvoie la vraie fonction de calcul de fibonacci
 *)
let mfibo n =
    let (memo : bigint array) = Array.zeroCreate (n + 3)

    let rec resetmemo k =
        if k >= 0
        then memo.[k] <- 0I; resetmemo (k - 1)
        else 0

    let result_reset = resetmemo (n + 2)

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

    get_fibo;;

(*
 * doit
 * boucle principale
 *)
let doit str_numberOfTests =
    try
        let numberOfTests = int str_numberOfTests
        let lafibo = mfibo numberOfTests

        let show_fibo k = printfn "fibo %d = %s" k (string (lafibo k))

        let rec show_all_fibos n =
            match n with
            | 0 -> show_fibo 0
            | _ -> show_fibo n; show_all_fibos (n - 1)

        show_all_fibos numberOfTests
        0
    with
        | :? System.FormatException -> eprintfn "Bad argument!"; dohelp 1;;



[<EntryPoint>]
let main args =
    let l = args.Length

    if l = 1
        then doit args.[0]
        else dohelp 0;;

