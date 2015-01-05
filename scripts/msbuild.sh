#!/bin/sh

filepath=$1
filepath=$(echo $filepath | sed -e 's/\/home\/srokadia/~/g')
dirpath=${filepath%/*}

echo "Starting ssh win dospath."
dosdirpath=$(ssh win "cygpath -w $dirpath")
echo "Finished ssh win dospath."

regexdosdir=$(echo -E "$dosdirpath\\" | sed -e 's/\\/\\\\/g')
echo "Starting MSBuild."
/bin/time ssh win "MSBuild.exe /m /nodereuse:false /v:q /p:GenerateFullPaths=true \$(cygpath -w $filepath) /p:StyleCop=false /p:BuildProjectReferences=true" | sed -e "s/$regexdosdir//Ig" -e 's/\\/\//g'
echo "Finished MSBuild."
cd $(dirname $1)

