## Environment variable configuration
# LANG
export LANG=ja_JP.UTF-8

# Turn on 256 color support...
if [ "$TERM" = "xterm" ]
then
    export TERM="xterm-256color"
fi

## complate
# default
autoload -U compinit
compinit

# Auto change direcotry
setopt auto_cd

# Saving cd history
setopt auto_pushd

# Teach error of command
setopt correct

# Compact list of complate result
setopt list_packed

# Beep sound off
setopt nolistbeep

## keybind
# vi bind
bindkey -v

## History
# Limit of history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Share history
setopt hist_ignore_dups
setopt share_history

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

## Customize prompt
autoload colors
colors

# localhost info
local p_rhst=""
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rhost=`who am i|sed 's/ .*(\(.*\)).*/\1/'`
    rhost=${rhost#localhost:}
    rhost=${rhost%%.*}
    p_rhst="%B%F{yellow}($rhost)%f%b"
fi

# current directory
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'

# macine and user info
local p_info="%n@%m${WINDOW:+"[$WINDOW]"}"

# command result mark
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"


# show git status
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
 
setopt prompt_subst
setopt re_match_pcre
 
function rprompt-git-current-branch {

local name st color

if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
fi

name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
if [[ -z $name ]]; then
    return
fi
 
st=`git status 2> /dev/null`
if [[ "$st" =~ "(?m)^nothing to" ]]; then
    color=%F{green}
elif [[ "$st" =~ "(?m)^nothing added" ]]; then
    color=%F{yellow}
elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
    color=%B%F{red}
else
    color=%F{red}
fi
 
echo "$color($name)%f%b "
}

local p_git='`rprompt-git-current-branch`'
local p_dir="%F{yellow}(%~)%f"

local cp_dir=" $p_dir$p_git"$'\n'
local cp_user=" %F{yellow}[$p_rhst$p_info]%f $p_mark "

PROMPT=$cp_dir$cp_user

