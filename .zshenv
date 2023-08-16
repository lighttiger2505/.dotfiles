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

# Mac
ZSH_DISABLE_COMPFIX="true"

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))
