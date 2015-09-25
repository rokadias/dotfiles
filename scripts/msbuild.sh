#!/bin/sh

filepath=$1
localdirpath=${filepath%/*}
localdirpath=$(dirname $localdirpath)
filepath=$(echo $filepath | sed -e 's/\/home\/srokadia/~/g')
dirpath=${filepath%/*}
dirpath=$(dirname $dirpath)

echo "Starting ssh win dospath."
dosdirpath=$(ssh dev.win "cygpath -w ~")
echo "Finished ssh win dospath."

echo $filepath | grep 'test.csproj$'
if [ $? -eq 0 ] && [ -d "$localdirpath/test/" ]
then
    rm -rf $localdirpath/test/bin/
fi

rsyncpath=$(echo $dirpath | sed -e 's/~\///g')
echo "Starting rsync win."
rsync -az --filter="merge /home/srokadia/scripts/rsyncignore" --delete $localdirpath/* dev.win:$rsyncpath
echo "Finished rsync win."

regexdosdir=$(echo -E "$dosdirpath\\" | sed -e 's/\\/\\\\/g')
echo "Starting MSBuild."
/bin/time ssh dev.win "TEMP=/tmp MSBuild.exe /m /nodereuse:false /v:q /p:GenerateFullPaths=true \$(cygpath -w $filepath) /p:StyleCop=false /p:BuildProjectReferences=true" | sed -e "s/$regexdosdir/~\//Ig" -e 's/\\/\//g'
echo "Finished MSBuild."

echo $filepath | grep 'test.csproj$'
if [ $? -eq 0 ] && [ -d "$localdirpath/test/" ]
then
    echo "Starting rsync test folder."
    mkdir $localdirpath/test/bin/
    rsync -az --filter="merge /home/srokadia/scripts/rsyncignore" --delete dev.win:$rsyncpath/test/bin/* $localdirpath/test/bin/
fi  

cd $(dirname $1)
