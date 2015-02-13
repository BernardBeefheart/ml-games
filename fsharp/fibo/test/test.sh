#!/bin/sh

version=Debug

dohelp () {
	exitCode=$1
	cat << EOF
$(basename $0) [Debug|debug|Release|release|--help]
	Debug|debug		: debug version,
	Release|release	: release version,
	--help			: this text
	if no arguments, then Debug
EOF
	exit $exitCode
}


if [ $# -eq 1 ]
then
	case $1 in
		Debug|debug)
			version=Debug
			;;
		Release|release)
			version=Release
			;;
		--help|-h)
			dohelp 0
			;;
		*)
			dohelp 1
			;;
	esac
fi

(../bin/${version}/startfsharp.exe  1 2; ../bin/${version}/startfsharp.exe a; ../bin/${version}/startfsharp.exe 10) > result.txt 2>&1
diff result.txt reference.txt && echo "OK"
