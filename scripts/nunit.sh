#!/bin/sh

assemblypath=$1
assemblypath=$(echo $assemblypath | sed -e 's#/home/srokadia#~#g')
assemblypath=$(echo $assemblypath | sed -e 's#bin/Debug/#bin/#g')
echo "Starting ssh assemblypath dospath."
dosdirpath=$(ssh dev.win "cygpath -w ~")
assemblydospath=$(ssh dev.win "cygpath -w $assemblypath")
echo "Finished ssh assemblypath dospath."

argumentList=$(echo -E "$assemblydospath" | sed -e 's/\\/\\\\\\/g')

if [ -n "$2" ]
then
    argumentList="$argumentList -run=$2"
fi

regexdosdir=$(echo -E "$dosdirpath\\" | sed -e 's/\\/\\\\/g')
echo "Starting nunit run."
ssh -t dev.win "bash -cl \"nunit-console.exe -nologo $argumentList\"" | sed -e "s/$regexdosdir/~\//Ig" -e 's/\\/\//g'
echo "Starting nunit run."
