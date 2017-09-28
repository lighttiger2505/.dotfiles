#!/usr/local/bin/zsh

#####################################################################
# init
#####################################################################
source ~/.zshenv

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
# path/valiables
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
