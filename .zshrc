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

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

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
source ~/.dotfiles/zsh/completion.zsh

# prompt
source ~/.dotfiles/zsh/prompt.zsh

# peco selection
source ~/.dotfiles/zsh/peco.zsh

# keybind
source ~/.dotfiles/zsh/keybind.zsh

# plugin manager
source ~/.dotfiles/zsh/zplug.zsh

# Init pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
