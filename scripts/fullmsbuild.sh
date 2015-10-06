#!/bin/sh

filepath=$1
localdirpath=$(dirname $filepath)
filepath=$(echo $filepath | sed -e 's/\/home\/srokadia/~/g')
dirpath=$(dirname $filepath)

echo "Starting ssh win dospath."
dosrootdirpath=$(ssh dev.win "cygpath -w ~")
dosfilepath=$(ssh dev.win "cygpath -w $filepath")
dosdirpath=$(ssh dev.win "cygpath -w $dirpath")
echo "Finished ssh win dospath."

rsyncpath=$(echo $dirpath | sed -e 's/~\///g')
echo "Starting rsync win."
rsync -az --filter="merge /home/srokadia/scripts/rsyncignore" --delete $localdirpath/* dev.win:$rsyncpath
echo "Finished rsync win."

regexdosdir=$(echo -E "$dosrootdirpath\\" | sed -e 's/\\/\\\\/g')
dosfilepath=$(echo -E "$dosfilepath" | sed -e 's/\\/\\\\/g')
echo "Starting MSBuild."
/bin/time ssh dev.win "TEMP=/tmp MSBuild.exe /m \"/t:FxCop;MakePublishDirectory\" /nodereuse:false /v:q /p:GenerateFullPaths=true $dosfilepath" | sed -e "s/$regexdosdir/~\//Ig" -e 's/\\/\//g'
echo "Finished MSBuild."

echo "Starting publish."
publishpath=$(echo -E "$dosdirpath\\x86\\")
echo "Publish Path: $publishpath"
ssh -t dev.master "sudo salt srok-www-1 state.sls nexus.publish pillar=\"{publish_source: '$publishpath'}\""
echo "Finished publish."

cd $(dirname $1)
