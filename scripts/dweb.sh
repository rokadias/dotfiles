#!/bin/bash

dirpath=$PWD

while [[ $dirpath != "" ]] && [ ! -f $dirpath/global.json ]
do
    dirpath=${dirpath%/*}
done

if [ ! -f $dirpath/global.json ]
then
    dirpath=$PWD
fi

docker run --rm --name web --volumes-from=dotnet-data -p 80:5000 -v "$dirpath":/myapp -w /myapp/src/Web microsoft/dotnet dotnet run
