(*
 * mlb-maker.sml
 * generated on lun 18 aoû 2014 15:47:11 CEST by bernard
 *)

open BtIO;


fun decrypt_args args =
let
  val size = length args;
  val files : string option array = Array.array(size, NONE);
  val libs : string option array = Array.array(size, NONE);
  val name : string option array = Array.array(size, NONE);

  datatype decstate = DS_NONE | DS_LIBS | DS_FILES | DS_NAME;



  fun idecrypt [] _ files libs name  = (files, libs, name)
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
        (files, libs, name);

  val result = idecrypt args DS_NONE [] [] "<no name>"

  fun show_list message list =
  let
    val _ = print "liste ";
    fun ishow [] = print "\n"
      | ishow (h :: t) = 
      let
        val _ = print " ";
      in
        print h;
        print "\n";
        ishow t
      end;
  in
    print message;
    print "\n";
    ishow list
  end;

  fun show_result (files, libs, name) =
  let
    val _ = show_list "files :" files;
    val _ = show_list "libs : " libs;
  in
    print "name : ";
   print name;
   print "\n"
  end;
in
  show_result result
end;

fun main () =
let
  val args = CommandLine.arguments ();
  

in
  decrypt_args args
end;  


main ();	
