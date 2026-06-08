#!/usr/bin/zsh

# Check if a command is executable
executable() {
    type "$1" &> /dev/null ;
}

# Compile a script to .zwc when missing or outdated, then source it.
src() {
  local f="$1"
  if [[ -s "$f" && ( ! -s "$f.zwc" || "$f" -nt "$f.zwc" ) ]]; then
    zcompile "$f"
  fi
  source "$f"
}

src $HOME/.zsh/ssh.zsh
src $HOME/.zsh/env.zsh
src $HOME/.zsh/path.zsh
src $HOME/.zsh/alias.zsh
src $HOME/.zsh/prompt.zsh
src $HOME/.zsh/setopt.zsh
src $HOME/.zsh/completion.zsh
src $HOME/.zsh/fzf.zsh
src $HOME/.zsh/keybind.zsh
src $HOME/.zsh/tmux.zsh
src $HOME/.zsh/command_hook_sync.zsh
src $HOME/.zsh/plugin.zsh
zsh-defer source $HOME/.zsh/command_hook_lazy.zsh
