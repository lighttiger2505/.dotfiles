#!/usr/local/bin/zsh

# histry file
export HISTFILE=~/.zsh_history
export HISTSIZE=6000000
export SAVEHIST=6000000
# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
# golang
export GOPATH=$HOME/dev
export GO111MODULE=auto
export GOPRIVATE="github.com/MobilityTechnologies"
# Neovim
export XDG_CONGIG_HOME=~/.config
# defaut editor is vim
export EDITOR=nvim
# goenv
GOENV_ROOT="$HOME/.goenv"

# Mac
ZSH_DISABLE_COMPFIX="true"

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# Switch Claude config dir based on hostname
case "$(hostname)" in
  PC-71285)
    export CLAUDE_CONFIG_DIR="$HOME/.claude-work"
    export VIM_MEMO_DIR="$HOME/.config/vimmemo/work"
    ;;
  *)
    export CLAUDE_CONFIG_DIR="$HOME/.claude-private"
    export VIM_MEMO_DIR="$HOME/.config/vimmemo/private"
    ;;
esac
