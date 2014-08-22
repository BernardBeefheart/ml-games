(*
 * fibo.fs
 * version FSharp
 * calcul des nombres de Fibonacci avec memoïzation
 * calcul jusqu'à 46 pour les entiers 32 bits
 *)

module fibo

let rec fibo n =
    match n with
    | 0 -> 0
    | 1 -> 1
    | _ -> fibo (n - 1) + fibo (n - 2);;

let rec fibo2 = function
    | 0 -> 0
    | 1 -> 1
    | n -> fibo2 (n - 1) + fibo2 (n - 2);;

let mfibo n =
    let (memo : bigint array) = Array.zeroCreate (n + 1)

    let rec get_fibo = function
        | 0 -> 0I
        | 1 -> 1I
        | n -> if memo.[n] = 0I
                    then
                        let f = get_fibo (n - 1) + get_fibo(n - 2)
                        memo.[n] <- f
                        f
                    else memo.[n]
    get_fibo;;


