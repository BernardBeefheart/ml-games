(* 
 * BaseName.sml
 *)

 signature BASENAME =
 sig
   val base_name : string -> string;
 end;

structure BaseName: BASENAME =
struct
  local
    fun get_base_name [] acc = rev acc
      | get_base_name (#"/" :: t) _ =  get_base_name t []
      | get_base_name (h :: t) acc = get_base_name t (h :: acc);

    fun del_extension [] acc = rev acc
      | del_extension (#"." :: t) acc = rev acc
      | del_extension (h :: t) acc = del_extension t (h :: acc);
  in      
    fun base_name file_name =
      implode (del_extension (get_base_name (explode file_name) []) []);
  end; 
end;
