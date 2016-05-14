#!/bin/sh

cd $(dirname $1)

dnu restore --quiet
dnu build --quiet
