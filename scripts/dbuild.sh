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

dotnet build $1
