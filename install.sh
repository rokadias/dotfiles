#!/bin/sh

mkdir ~/scripts
ln -s $PWD/scripts/dbuild.sh ~/scripts/dbuild.sh
ln -s $PWD/scripts/dtest.sh ~/scripts/dtest.sh
ln -s $PWD/scripts/dweb.sh ~/scripts/dweb.sh
ln -s $PWD/scripts/msbuild.sh ~/scripts/msbuild.sh
ln -s $PWD/scripts/fullmsbuild.sh ~/scripts/fullmsbuild.sh
ln -s $PWD/scripts/rsyncignore ~/scripts/rsyncignore
ln -s $PWD/scripts/nunit.sh ~/scripts/nunit.sh
ln -s $PWD/scripts/xunit.sh ~/scripts/xunit.sh

mkdir ~/.xmonad/
ln -s $PWD/home/xmonad/xmonad.hs ~/.xmonad/

ln -s $PWD/emacs/emacs ~/.emacs
mkdir -p ~/.emacs.d/srokadia
ln -s $PWD/emacs/emacs.d/srokadia/autocomplete.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/bindings.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/compile.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/csharp.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/css.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/custom.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/erc.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/find-file-in-repository.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/flycheck.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/generalfunctions.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/global.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/handlebars.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/haskell.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/hg.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/git.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/html.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/javascript.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/jsx.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/key-chord.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/org.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/package.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/powershell.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/progmodefunctions.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/restclient.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/session.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/shell.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/theme.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/yaml.el ~/.emacs.d/srokadia/
ln -s $PWD/emacs/emacs.d/srokadia/yasnippet.el ~/.emacs.d/srokadia/

ln -s $PWD/emacs/emacs.d/elpa ~/.emacs.d/
ln -s $PWD/emacs/emacs.d/lisp ~/.emacs.d/
ln -s $PWD/emacs/emacs.d/snippets ~/.emacs.d/

ln -s $PWD/home/bashrc ~/.bashrc
ln -s $PWD/home/bash_profile ~/.bash_profile
ln -s $PWD/home/conkyrc ~/.conkyrc
ln -s $PWD/home/eslintrc ~/.eslintrc
ln -s $PWD/home/xinitrc ~/.xinitrc
ln -s $PWD/home/xmodmap ~/.xmodmap
ln -s $PWD/home/xprofile ~/.xprofile
ln -s $PWD/home/zprofile ~/.zprofile
ln -s $PWD/home/zshenv ~/.zshenv
ln -s $PWD/home/zshrc ~/.zshrc

sudo ln -s $PWD/etc/pacman.conf /etc/
sudo ln -s $PWD/etc/pacman.d/mirrorlist /etc/pacman.d/

sudo cp $PWD/etc/systemd/system/docker.service /etc/systemd/system/
sudo cp $PWD/etc/systemd/user/skydns.service /etc/systemd/user/
sudo cp $PWD/etc/systemd/user/skydock.service /etc/systemd/user/
sudo cp $PWD/etc/systemd/user/evincer.service /etc/systemd/user/
sudo cp $PWD/etc/systemd/user/nexxusblog.service /etc/systemd/user/
sudo cp $PWD/etc/systemd/user/trunk-mysql.service /etc/systemd/user/
sudo cp $PWD/etc/systemd/user/redis-container.service /etc/systemd/user/
