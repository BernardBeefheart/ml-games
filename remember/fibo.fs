(*
 * fibo.fs
 * version FSharp
 * calcul des nombres de Fibonacci avec memoïzation
 * calcul jusqu'à 46 pour les entiers 32 bits
 *)

module fibo

let mfibo n =
    let (memo : bigint array) = Array.zeroCreate (n + 1)

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


let dohelp exitValue =
    printfn "Usage:"
    printfn "   fibo.exe Number"
    exitValue;;

let doit astr =
    try
        let v = int astr
        let lafibo = mfibo v

        let show_fibo k =
            let fk = lafibo k
            let sfk = string fk
            printfn "fibo %d = %s" k sfk

        let rec show_all_fibos n =
            match n with
            | 0 -> show_fibo 0
            | _ ->
            let _ = show_fibo n
            show_all_fibos (n - 1)

        show_all_fibos v
        0
    with
        | :? System.FormatException -> eprintfn "Bad argument!"; dohelp 1;;



[<EntryPoint>]
let main args =
    let l = args.Length

    if l = 1
        then doit args.[0]
        else dohelp 0;;

