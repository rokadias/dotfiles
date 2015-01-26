# Requires the PSCX extensions in order to use New-Symlink

New-Symlink $HOME\.emacs $PWD\emacs\emacs

mkdir -p $HOME\.emacs.d\srokadia
New-Symlink $HOME\.emacs.d\srokadia\bindings.el $PWD\emacs\emacs.d\srokadia\bindings.el
New-Symlink $HOME\.emacs.d\srokadia\csharp.el $PWD\emacs\emacs.d\srokadia\csharp.el
New-Symlink $HOME\.emacs.d\srokadia\custom.el $PWD\emacs\emacs.d\srokadia\custom.el
New-Symlink $HOME\.emacs.d\srokadia\erc.el $PWD\emacs\emacs.d\srokadia\erc.el
New-Symlink $HOME\.emacs.d\srokadia\generalfunctions.el $PWD\emacs\emacs.d\srokadia\generalfunctions.el
New-Symlink $HOME\.emacs.d\srokadia\global.el $PWD\emacs\emacs.d\srokadia\global.el
New-Symlink $HOME\.emacs.d\srokadia\haskell.el $PWD\emacs\emacs.d\srokadia\haskell.el
New-Symlink $HOME\.emacs.d\srokadia\hg.el $PWD\emacs\emacs.d\srokadia\hg.el
New-Symlink $HOME\.emacs.d\srokadia\html.el $PWD\emacs\emacs.d\srokadia\html.el
New-Symlink $HOME\.emacs.d\srokadia\javascript.el $PWD\emacs\emacs.d\srokadia\javascript.el
New-Symlink $HOME\.emacs.d\srokadia\org.el $PWD\emacs\emacs.d\srokadia\org.el
New-Symlink $HOME\.emacs.d\srokadia\package.el $PWD\emacs\emacs.d\srokadia\package.el
New-Symlink $HOME\.emacs.d\srokadia\powershell.el $PWD\emacs\emacs.d\srokadia\powershell.el
New-Symlink $HOME\.emacs.d\srokadia\progmodefunctions.el $PWD\emacs\emacs.d\srokadia\progmodefunctions.el
New-Symlink $HOME\.emacs.d\srokadia\restclient.el $PWD\emacs\emacs.d\srokadia\restclient.el
New-Symlink $HOME\.emacs.d\srokadia\session.el $PWD\emacs\emacs.d\srokadia\session.el
New-Symlink $HOME\.emacs.d\srokadia\shell.el $PWD\emacs\emacs.d\srokadia\shell.el
New-Symlink $HOME\.emacs.d\srokadia\theme.el $PWD\emacs\emacs.d\srokadia\theme.el
New-Symlink $HOME\.emacs.d\srokadia\yaml.el $PWD\emacs\emacs.d\srokadia\yaml.el
New-Symlink $HOME\.emacs.d\srokadia\yasnippet.el $PWD\emacs\emacs.d\srokadia\yasnippet.el

New-Symlink $HOME\.emacs.d\elpa $PWD\emacs\emacs.d\elpa
New-Symlink $HOME\.emacs.d\lisp $PWD\emacs\emacs.d\lisp
New-Symlink $HOME\.emacs.d\plugins $PWD\emacs\emacs.d\plugins

New-Symlink $HOME\.bashrc $PWD\home\bashrc
New-Symlink $HOME\.bash_profile $PWD\home\bash_profile
New-Symlink $HOME\.xprofile $PWD\home\xprofile
New-Symlink $HOME\.zprofile $PWD\home\zprofile
New-Symlink $HOME\.zshenv $PWD\home\zshenv
New-Symlink $HOME\.zshrc $PWD\home\zshrc
