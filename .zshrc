## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors

local p_rhst=""
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rhost=`who am i|sed 's/ .*(\(.*\)).*/\1/'`
    rhost=${rhost#localhost:}
    rhost=${rhost%%.*}
    p_rhst="%B%F{yellow}($rhost)%f%b"
fi
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_info="%n@%m${WINDOW:+"[$WINDOW]"}"
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
PROMPT=" $p_cdir$p_rhst$p_info $p_mark "

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
 
setopt prompt_subst
setopt re_match_pcre
 
function rprompt-git-current-branch {
local name st color gitdir action
if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
return
fi
name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
if [[ -z $name ]]; then
return
fi
 
gitdir=`git rev-parse --git-dir 2> /dev/null`
action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
 
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
 
echo "$color$name$action%f%b "
}
 
RPROMPT='(`rprompt-git-current-branch`%~)'
