#!/usr/bin/zsh

# Check if a command is executable
executable() {
    type "$1" &> /dev/null ;
}

# Load path and env first
source $HOME/.zsh/path.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/alias.zsh
# not lazy loading
source $HOME/.zsh/sync.zsh
# Load command hook
source $HOME/.zsh/command_hook.zsh
# lazy loading for zsh plugin and zsh hooks
source $HOME/.zsh/lazy.zsh
