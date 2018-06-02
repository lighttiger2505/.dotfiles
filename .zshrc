#!/usr/local/bin/zsh

# zprof start
# zmodload zsh/zprof && zprof

# OS Type
case ${OSTYPE} in
    darwin*)
        [[ -f ~/.zshrc.osx ]] && source ~/.dotfiles/.zshrc.osx
        ;;
    linux-gnu*)
        [[ -f ~/.zshrc.linux ]] && source ~/.dotfiles/.zshrc.linux
        ;;
esac

# load settings
source ~/.zsh/completion.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/keybind.zsh
source ~/.zsh/zplugin.zsh

# Python
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

# Init anyenv
if [ -e ~/.anyenv ]; then
    eval "$(anyenv init -)"

    # Load awsclid complation
    if type aws > /dev/null 2>&1; then
        source "$(pyenv which aws_zsh_completer.sh)"
    fi
fi

eval $(ssh-agent) > /dev/null
ssh-add ~/.ssh/id_rsa > /dev/null 2>&1

# zprof end
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi
