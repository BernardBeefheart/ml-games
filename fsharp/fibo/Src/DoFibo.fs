(*
 * DoFibo.fs
 * calcul et affichage des nombres de Fibonacchi
 *)

module DoFibo

open Constants
open Help

(*
 * exception déclenchée en cas de nombre négatif
 *)

exception NegativeNumber of string



(*
 * memoiseFibo n
 * mémoïsation de la suite de fibonacci. cette fonction est une fermeture qui garde 
 * le tableau des valeurs calculées en mémoire
 * n : le nombre de Fibonacchi à calculer
 * return : renvoie la vraie fonction de calcul de fibonacci
 *)
let memoiseFibo n =
    (* calcul de la taille du tableau de mémoïsation *)
    let asize = if n < 3
                then 3
                else n + 1

    (* création du tableau de mémoïzatio *)
    let (memo : bigint array) = Array.zeroCreate asize

    (* fonction de calcul des nombres de fibonacchi *)
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
 * doFibo str_numberOfTests
 * boucle principale
 * str_numberOfTests : le nombre de valeurs à calculer et afficher
 * return le code de sortie du programme
 *)
let doFibo (str_numberOfTests:string) : int =
    try
        (* nombre de valeurs à calculer et afficher transformer en int *)
        let numberOfTests = int str_numberOfTests
        (* génération d'une exception si ce nombre est négatif *)
        if numberOfTests < 0
            then raise (NegativeNumber ("Error: Negative number!"))
            else printfn ""

        (* création de la fonction de calcul *)
        let lafibo = memoiseFibo numberOfTests

        (* fonction d'affichage d'une valeur *)
        let show_fibo k = printfn "fibo %d -> %s" k (string (lafibo k))

        (* fonction d'affichage de toutes les valeurs *)
        let rec show_all_fibos n =
            show_fibo n
            if n <> numberOfTests then show_all_fibos (n + 1)

        (* lancement des calculs *)
        show_all_fibos 0
        ExitSuccess

    with
        (* gestion des exceptions *)
        | NegativeNumber(str) -> dohelp ExitErrorNegative
        | :? System.FormatException -> dohelp ExitErrorBadArgs
        | _ -> dohelp ExitErrorUnknown;;

