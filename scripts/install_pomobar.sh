#!/usr/bin/env bash
set -ex

cd ~/OpenSource

git clone ssh://github.com/rlcintra/pomobar.git

cd pomobar

stack setup
stack build
stack install
