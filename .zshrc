#!/usr/bin/zsh

# Check if a command is executable
executable() {
    type "$1" &> /dev/null ;
}

source $HOME/.zsh/ssh.zsh
source $HOME/.zsh/path.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/prompt.zsh
source $HOME/.zsh/setopt.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/fzf.zsh
source $HOME/.zsh/keybind.zsh
source $HOME/.zsh/command_hook.zsh
source $HOME/.zsh/tmux.zsh

# lazy loading for zsh plugin and zsh hooks
source $HOME/.zsh/lazy.zsh
