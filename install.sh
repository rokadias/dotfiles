#!/bin/sh

mkdir ~/scripts
ln -s $PWD/scripts/msbuild.sh ~/scripts/msbuild.sh

mkdir ~/.xmonad/
ln -s $PWD/xmonad/xmonad.hs ~/.xmonad/

ln -s $PWD/emacs/emacs ~/.emacs
mkdir ~/.emacs.d

ln -s $PWD/home/bashrc ~/.bashrc
ln -s $PWD/home/bash_profile ~/.bash_profile
ln -s $PWD/home/conkyrc ~/.conkyrc
ln -s $PWD/home/xinitrc ~/.xinitrc
ln -s $PWD/home/xmodmap ~/.xmodmap
ln -s $PWD/home/xprofile ~/.xprofile
ln -s $PWD/home/zprofile ~/.zprofile
ln -s $PWD/home/zshenv ~/.zshenv
ln -s $PWD/home/zshrc ~/.zshrc

sudo ln -s $PWD/etc/pacman.conf /etc/
sudo ln -s $PWD/etc/pacman.d/mirrorlist /etc/pacman.d/

sudo cp $PWD/etc/systemd/system/docker.service /etc/systemd/system/
sudo cp $PWD/etc/systemd/user/evincer.service /etc/systemd/user/
