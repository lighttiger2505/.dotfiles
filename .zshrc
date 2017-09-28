#!/usr/local/bin/zsh

#####################################################################
# init
#####################################################################
# load zshrc for os type
case ${OSTYPE} in
    darwin*)
        [[ -f ~/.zshrc.osx ]] && source ~/.dotfiles/.zshrc.osx
        ;;
    linux-gnu*)
        [[ -f ~/.zshrc.linux ]] && source ~/.dotfiles/.zshrc.linux
        ;;
esac

#####################################################################
# Exports
#####################################################################
# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# zplug
export ZPLUG_HOME=$HOME/.zplug
# golang
export GOPATH=$HOME/dev
# pyenv
export PYENV_PATH=$HOME/.pyenv
# Neovim
export XDG_CONGIG_HOME=~/.config
# ls cmd color
export LSCOLORS=gxfxcxdxbxegedabagacad

# defaut editor is vim
export EDITOR=nvim

# when not exist vim then start up vi
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi
# when not exist nvim then start up vim
if ! type vim > /dev/null 2>&1; then
    alias nvim=vim
fi

#####################################################################
# Path/Valiables
#####################################################################
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
$PYENV_PATH/shims(N-/)
)

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

## Limit of history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#####################################################################
# load settings
#####################################################################
# auto complete
source ~/.zsh/completion.zsh

# prompt
source ~/.zsh/prompt.zsh

# peco function
source ~/.zsh/peco.zsh

# fzf functions
source ~/.zsh/fzf.zsh

# alias
source ~/.zsh/alias.zsh

# keybind
source ~/.zsh/keybind.zsh

# plugin manager
source ~/.zsh/zplug.zsh

# Init pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
