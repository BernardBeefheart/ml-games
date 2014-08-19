(*
 * mlb-maker.sml
 * generated on lun 18 aoû 2014 15:47:11 CEST by bernard
 *)

open BtIO MlbDecryptArgs BaseName;

fun make_mlb values =
let
  val user = case OS.Process.getEnv "USER"
              of SOME r => r
                | NONE => "<unknown user>";
            

  fun file_header name extension = (
    printLn ["(*"];
    printLn [" * ", name, ".", extension];
    printLN [" * created by ", user];
    printLn [" *)"]; 
    printLn [""] 
    );

  fun print_list_of_files [] _ = print "\n"
    | print_list_of_files (h :: t) text_before = (
        printLn [text_before, h];
        print_list_of_files t text_before
        );

  fun file_libs libs = print_list_of_files libs "\t";

  fun file_files files = print_list_of_files files "\t";

  fun structures libs = print_list_of_files (map base_name libs) "\tstructure";

  fun doit (files, libs, name) = (
    file_header name ".mlb";
    print "local\n";
    print "\t(* import Basis Library *)\n";
    print "\t$(SML_LIB)/basis/basis.mlb\n";
    file_libs libs;
    print "in\n";
    structures libs;
    file_files files;
    print "end\n"
    );  
in
  doit values
end;

fun main () =
let
  val args = CommandLine.arguments ();
  val result = decrypt_args args;
in
  make_mlb result
end;  


main ();	
