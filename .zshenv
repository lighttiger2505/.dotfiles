#!/usr/local/bin/zsh

# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
# golang
export GOPATH=$HOME/dev
# anyenv
export ANYENV_PATH=$HOME/.anyenv
# pyenv
export PYENV_PATH=$HOME/.pyenv
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
# # java
if [ -e /usr/libexec/java_home ]; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
fi
# Neovim
export XDG_CONGIG_HOME=~/.config
# defaut editor is vim
export EDITOR=nvim

# Path/Valiables
typeset -U path
path=(
# bin
/usr/local/bin(N-/)
/usr/bin(N-/)
/bin(N-/)
# sbin
/usr/local/sbin(N-/)
/usr/sbin(N-/)
/sbin(N-/)
#gnubin
/usr/local/opt/coreutils/libexec/gnubin(N-/)
# Java
$JAVA_HOME/bin(N-/)
# Cabal
$HOME/.cabal/bin(N-/)
# rvm(ruby version control)
$HOME/.rvm/bin(N-/)
# Go lang
$GOPATH/bin(N-/)
# pyenv
$PYENV_PATH/bin(N-/)
# $PYENV_PATH/shims(N-/)
# anyenv
$ANYENV_PATH/bin(N-/)
# $ANYENV_PATH/shims(N-/)
)

# Go root
export GOROOT=$(go env GOROOT)

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))
