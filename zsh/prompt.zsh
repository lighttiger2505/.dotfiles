# show git status
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

setopt prompt_subst
setopt re_match_pcre

function rprompt-git-current-branch {
    # local name st color
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
local p_vimjob='$([[ $(jobs|grep -c vim) != 0 ]] && print "vim")'
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"

local prow_dir=" $p_dir$p_git"$'\n'
local prow_user=" %F{yellow}[%n@%m]%f%F{green}[$p_vimjob]%f $p_mark "

PROMPT=$prow_dir$prow_user

