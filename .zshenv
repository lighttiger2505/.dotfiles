#!/usr/local/bin/zsh

# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
# golang
export GOPATH=$HOME/dev
export GO111MODULE=auto
export GOPRIVATE="github.com/MobilityTechnologies"
# anyenv
export ANYENV_PATH=$HOME/.anyenv
# pyenv
export PYENV_PATH=$HOME/.pyenv
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
# Neovim
export XDG_CONGIG_HOME=~/.config
# defaut editor is vim
export EDITOR=nvim
# enhancd disable fzf-tmux
export ENHANCD_FILTER=fzf
# defaut terminal is alacritty
export TERMINAL=alacritty
# # dolphin file explorer icon setting
# [ "$XDG_CURRENT_DESKTOP" = "KDE" ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || export QT_QPA_PLATFORMTHEME="qt5ct"
# AWS profile
AWS_DEFAULT_PROFILE=default

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
# Cabal
$HOME/.cabal/bin(N-/)
# rvm(ruby version control)
$HOME/.rvm/bin(N-/)
# Go lang
$GOPATH/bin(N-/)
# pyenv
$PYENV_PATH/bin(N-/)
# anyenv
$ANYENV_PATH/bin(N-/)
# npm bin
$HOME/.npm-global/bin(N-/)
# my scripts
$HOME/scripts(N-/)

# GNU utils for mac
# coreutils
/usr/local/opt/coreutils/libexec/gnubin(N-/)
# ed
/usr/local/opt/ed/libexec/gnubin(N-/)
# findutils
/usr/local/opt/findutils/libexec/gnubin(N-/)
# sed
/usr/local/opt/gnu-sed/libexec/gnubin(N-/)
# tar
/usr/local/opt/gnu-tar/libexec/gnubin(N-/)
# grep
/usr/local/opt/grep/libexec/gnubin(N-/)
${path}
)

manpath=(
# coreutils
/usr/local/opt/coreutils/libexec/gnubin(N-/)
# ed
/usr/local/opt/ed/libexec/gnubin(N-/)
# findutils
/usr/local/opt/findutils/libexec/gnubin(N-/)
# sed
/usr/local/opt/gnu-sed/libexec/gnubin(N-/)
# tar
/usr/local/opt/gnu-tar/libexec/gnubin(N-/)
# grep
/usr/local/opt/grep/libexec/gnubin(N-/)
${manpath}
)

# Go root
export GOROOT=$(go env GOROOT)

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))
