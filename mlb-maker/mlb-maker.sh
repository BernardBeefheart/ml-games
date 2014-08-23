#!/bin/sh

scriptname=$(basename $0)
files=
libs=
name=
state=none

dohelp () {
cat << EOHELP
$scriptname [--help] : this text
$scriptname --files files ... --libs libs ... --name mlbname
EOHELP
exit $1
}

onerror () {
	echo "ERROR: $*" &>2
	dohelp 1
}

alllibs () {
	for l in $libs
	do
		echo "	$l"
	done
}

allstruct() {
	for l in $libs
	do
		echo "	structure $(basename $l)" | sed 's/\.sml$//'
	done
}

allopen() {
	for l in $libs
	do
		echo "open $(basename $l);" | sed 's/\.sml$//'
	done
}

allfiles() {
	for f in $files
	do
		echo "	$f"
	done
}

onarg () {
	arg=$1
	case $state in
		files)
			files="$files $arg"
			;;
		libs)
			libs="$libs $arg"
			;;
		name)
			name=$arg
			;;
	esac	
}

[ $# -eq 0 ] && dohelp 0

while [ $# -ne 0 ]
do
	case $1 in
		--files)
			state=files
			;;	
		--libs)
			state=libs
			;;	
		--name)
			state=name
			;;	
		--help)
			dohelp 0
			;;	
		*)
			onarg $1
			;;	
	esac
	shift
done

[ "$name" = "" ] && onerror "You must give a name (--name)"
[ "$files" = "" ] && onerror "You must give at least a sml file name (--files)"


mlbname=$name.mlb
smlname=$name.sml

cat > $mlbname << EOMLB
(*
 * $mlbname
 * generated on $(date) by $USER
 *)

local
	(* import Basis Library *)
	\$(SML_LIB)/basis/basis.mlb
	$(alllibs)
in
	$(allstruct)
	$(allfiles)
end	
EOMLB

echo "$mlbname done"

if ! [ -f $smlname ]
then
	cat > $smlname << EOSML
(*
 * $smlname
 * generated on $(date) by $USER
 *)

 $(allopen)

fun main () =
	0;

main ();	
EOSML
fi

