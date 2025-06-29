#!/usr/bin/zsh

# Check if a command is executable
executable() {
    type "$1" &> /dev/null ;
}

# ssh-agent
if [ "$(pgrep ssh-agent 2> /dev/null)" = "" ]; then
    eval $(ssh-agent) > /dev/null
    case ${OSTYPE} in
        darwin*)
            ssh-add --apple-use-keychain ~/.ssh/id_rsa > /dev/null 2>&1
            ;;
        linux-gnu*)
            eval `keychain --eval --agents ssh ~/.ssh/id_rsa`
            ;;
    esac
fi

source $HOME/.zsh/path.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/prompt.zsh
source $HOME/.zsh/setopt.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/fzf.zsh
source $HOME/.zsh/keybind.zsh
source $HOME/.zsh/command_hook.zsh

# lazy loading for zsh plugin and zsh hooks
source $HOME/.zsh/lazy.zsh
