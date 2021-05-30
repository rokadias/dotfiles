#!/bin/bash

set -e

DOTFILES_DIR=$(realpath $(dirname $BASH_SOURCE[0]))
source $DOTFILES_DIR/exesudo.sh

linkIfNotExists() {
    local SOURCE=$1
    local DEST_PATH=$2
    local PREFIX=$3
    local BASENAME=$(basename $SOURCE)
    local DESTINATION=$DEST_PATH/$PREFIX$BASENAME

    if [[ ( -f "$SOURCE" ) && ( ! -f "$DESTINATION" ) ]] || [[ ( -d "$SOURCE" ) && ( ! -d "$DESTINATION" ) ]]; then
        echo "Linking: $SOURCE to $DESTINATION"
        ln -s $SOURCE $DESTINATION
    fi
}
export linkIfNotExists


linkFilesInDotfilesToPath() {
    local SOURCE_PATH=$DOTFILES_DIR/$1
    local DEST_PATH=$2
    local PREFIX=$3

    FILES=$(find $SOURCE_PATH -maxdepth 1 -type f )

    for f in $FILES
    do
        linkIfNotExists $f $DEST_PATH $PREFIX
    done
}
export linkFilesInDotfilesToPath

linkDirectoriesInDotfilesToPath() {
    local SOURCE_PATH=$DOTFILES_DIR/$1
    local DEST_PATH=$2
    local PREFIX=$3

    DIRECTORIES=$(find $SOURCE_PATH -mindepth 1 -maxdepth 1 -type d)

    for d in $DIRECTORIES
    do
        linkIfNotExists $d $DEST_PATH $PREFIX
    done
}
export linkDirectoriesInDotfilesToPath

echo $'\nLooking through home/xmonad/'
mkdir -p $HOME/scripts
linkFilesInDotfilesToPath scripts $HOME/scripts/

# Xmonad
echo $'\nLooking through home/xmonad/'
mkdir -p $HOME/.xmonad
linkFilesInDotfilesToPath home/xmonad/ $HOME/.xmonad

# emacs
echo $'\nLooking through emacs/'
mkdir -p $HOME/.emacs.d
linkIfNotExists $DOTFILES_DIR/emacs/emacs $HOME "."
linkDirectoriesInDotfilesToPath emacs/emacs.d $HOME/.emacs.d

# Home dotfiles
echo $'\nLooking through home/'
linkFilesInDotfilesToPath home/ $HOME "."

echo $'\nLooking through etc/pacman and etc/systemd/system'
if [[ $(whoami) == "root" ]]; then
    mkdir -p /etc/pacman.d
    linkIfNotExists $DOTFILES_DIR/etc/pacman.conf /etc
    linkIfNotExists $DOTFILES_DIR/etc/pacman.d/mirrorlist /etc/pacman.d

    cp $DOTFILES_DIR/etc/systemd/system/tmpfiles-cleanup.service /etc/systemd/system
    cp $DOTFILES_DIR/etc/systemd/system/tmpfiles-cleanup.timer /etc/systemd/system
else
    sudo mkdir -p /etc/pacman.d
    exesudo linkIfNotExists $DOTFILES_DIR/etc/pacman.conf /etc
    exesudo linkIfNotExists $DOTFILES_DIR/etc/pacman.d/mirrorlist /etc/pacman.d

    sudo cp $DOTFILES_DIR/etc/systemd/system/tmpfiles-cleanup.service /etc/systemd/system
    sudo cp $DOTFILES_DIR/etc/systemd/system/tmpfiles-cleanup.timer /etc/systemd/system
fi

echo $'\nLooking through etc/systemd/user'
if [[ -d $HOME/.local/share/systemd/user ]]; then
    find etc/systemd/user/ -maxdepth 1 -type p -exec cp {} $HOME/.local/share/systemd/user \;
fi
