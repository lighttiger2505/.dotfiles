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
# AWS profile
AWS_DEFAULT_PROFILE=default
# goenv
GOENV_ROOT="$HOME/.goenv"
# volta
export VOLTA_HOME="$HOME/.volta"

# Path/Valiables
typeset -U path
path=(
# brew
/opt/homebrew/bin(N-/)
/opt/homebrew/sbin(N-/)
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
# krew
${KREW_ROOT:-$HOME/.krew}/bin
# goenv
$GOENV_ROOT/bin(N-/)
# volta
$VOLTA_HOME/bin(N-/)

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

# Mac
ZSH_DISABLE_COMPFIX="true"

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

FZF_PREVIEW_PREVIEW_BAT_THEME='gruvbox'
. "$HOME/.cargo/env"
