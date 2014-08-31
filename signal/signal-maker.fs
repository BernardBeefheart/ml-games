(*
 * signal-maker.fs
 *
 * Crée 3 signaux carrés dont la fréquence, les déphasages et la fréquence
 * d'échantillonnage sur la ligne de commande.
 * On fourni aussi la durée du signal.
 *
 *)

module signalMaker

type TVoltState =
    | low = 0
    | high = 1

type TConfiguration() =
    let mutable signal_frequency:float = 50.0
    let mutable sample_frequency:float = 20000.0
    let mutable phase_diff:float = 0.0
    let mutable sample_duration:float = 10.0
    let mutable samples = 0
    let mutable samples_per_period = 0
    let mutable periods = 0

    let mutable vmin = -5.0
    let mutable vmax = 5.0

    let show_signal () =
        let rec show_basic k v =
            match k with
            | 0 -> 0
            | k ->
                printfn "%8.5f\t%8.5f\t%8.5f" v v v
                show_basic (k - 1) v

        let show_high samples = show_basic samples vmax
        let show_low samples = show_basic samples vmin

        let rec iloop kperiod =
            match kperiod with
            | 0 -> 0
            | kperiod ->
                show_high (samples_per_period / 2)
                show_low (samples_per_period / 2)
                iloop (kperiod - 1)

        iloop periods

    member this.Setsignal_frequency frequency =
        signal_frequency <- frequency
        this

    member this.Setsample_frequency frequency =
        sample_frequency <- frequency
        this

    member this.Setphase_diff diff_degrees =
        phase_diff <- diff_degrees
        this

    member this.Setsample_duration duration =
        sample_duration <- duration
        this

    member this.Getsignal_frequency =
        signal_frequency

    member this.Getsample_frequency =
        sample_frequency

    member this.Getphase_diff =
        phase_diff

    member this.Getsample_duration =
        sample_duration


    member this.show_me () =
        samples <- int (sample_frequency * sample_duration)
        samples_per_period <- int (sample_frequency / signal_frequency)
        periods <- samples / samples_per_period

        printfn "%8.1f\t%8.1f" sample_frequency sample_duration
        show_signal ()


type TFlag =
    | none = 0
    | signal_frequency = 1
    | sample_frequency = 2
    | phase_diff = 3
    | sample_duration = 4

[<EntryPoint>]
let main args =
    let configuration = new TConfiguration()

    let rec read_args args flag config =
        match args with
        | "--signal-frequency" :: t  -> read_args t TFlag.signal_frequency config
        | "--sample-frequency" :: t  -> read_args t TFlag.sample_frequency config
        | "--phase-diff" :: t  -> read_args t TFlag.phase_diff config
        | "--sample-duration" :: t  -> read_args t TFlag.sample_duration config
        | v :: t -> match flag with
                        | TFlag.signal_frequency -> read_args t TFlag.signal_frequency (configuration.Setsignal_frequency (float v))
                        | TFlag.sample_frequency -> read_args t TFlag.sample_frequency (configuration.Setsample_frequency (float v))
                        | TFlag.phase_diff -> read_args t TFlag.phase_diff (configuration.Setphase_diff (float v))
                        | TFlag.sample_duration -> read_args t TFlag.sample_duration (configuration.Setsample_duration (float v))
                        | TFlag.none -> read_args t TFlag.none config
        | [] -> config.show_me ()


    read_args (Array.toList args) TFlag.none configuration;;



