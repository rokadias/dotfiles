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

docker run --rm --volumes-from=dotnet-data -v "$dirpath":/myapp -w /myapp microsoft/dotnet sh -c "find ./src/ -name *.Tests -exec dotnet test {} \;"
