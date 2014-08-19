(*
 * MlbDecryptArgs.sml
 *)

 signature MLBDECRYPTARGS =
 sig
   exception BadArgument;
   val decrypt_args : string list -> string list * string list * string
 end;

structure MlbDecryptArgs: MLBDECRYPTARGS =
struct
  open BtIO
  datatype decstate = DS_NONE | DS_LIBS | DS_FILES | DS_NAME;

  exception BadArgument;

  fun decrypt_args args =
  let
    fun idecrypt [] _ files libs name  = (rev files, rev libs, name)
      | idecrypt ("--files"::t) _ files libs name =
      idecrypt t DS_FILES files libs name 
      | idecrypt ("--libs"::t) _ files libs name = 
      idecrypt t DS_LIBS files libs name 
      | idecrypt ("--name"::t) _ files libs name = 
      idecrypt t DS_NAME files libs name 
      | idecrypt (h::t) DS_LIBS files libs name =
      idecrypt t DS_LIBS files (h :: libs) name
      | idecrypt (h::t) DS_FILES files libs name =
      idecrypt t DS_FILES (h :: files) libs name
      | idecrypt (h::t) DS_NAME files libs name =
      idecrypt t DS_NAME files libs h
      | idecrypt _ DS_NONE files libs name =
      raise BadArgument;

    val result = idecrypt args DS_NONE [] [] "<no name>"

  in
    idecrypt args DS_NONE [] [] "<no name>"
  end;

end;
