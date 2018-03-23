#!/usr/local/bin/zsh

# zmodload zsh/zprof && zprof

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
# load settings
#####################################################################
# auto complete
source ~/.zsh/completion.zsh
# option set
source ~/.zsh/setopt.zsh
# prompt
source ~/.zsh/prompt.zsh
# fzf functions
source ~/.zsh/fzf.zsh
# alias
source ~/.zsh/alias.zsh
# keybind
source ~/.zsh/keybind.zsh
# plugin manager
source ~/.zsh/zplugin.zsh

# Init pyenv
if [ -e ~/.pyenv ]; then
    eval "$(pyenv init -)"
    if type aws > /dev/null 2>&1; then
        source "$(pyenv which aws_zsh_completer.sh)"
    fi
fi

# Init pyenv-virtualenv
if [ -e ~/.pyenv/plugins/virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
fi

#####################################################################
# Benchmark
#####################################################################
alias zbench='for i in $(seq 1 10); do time zsh -i -c exit; done'

#####################################################################
# Launch tmux
#####################################################################
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

