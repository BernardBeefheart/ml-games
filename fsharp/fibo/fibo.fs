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
open DoFibo



[<EntryPoint>]
let main args =
    let onArgs = function
        | 0 -> Help.dohelp ExitSuccess
        | 1 -> DoFibo.doFibo args.[0]
        | _ -> Help.dohelp ExitErrorTooMuchArgs

    onArgs args.Length;;
