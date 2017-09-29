autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo

setopt prompt_subst
setopt re_match_pcre

function current-git-branch-status {
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

    echo "$color$name%f%b"
}

function current-git-branch() {
    echo -n "$(git name-rev --name-only HEAD 2> /dev/null)"
}

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        main|viins)
            vimmode="$fg[blue]-- INSERT --$reset_color"
            ;;
        vicmd)
            vimmode="$fg[green]-- NORMAL --$reset_color"
            ;;
    esac

    local p_vimjob="[%F{green}$([[ $(jobs|grep -c vim) != 0 ]] && print "vim")%f]"
    local p_branch="{%F{blue}$(current-git-branch)%f}"
    local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
    PROMPT="%{$terminfo_down_sc$vimmode | %F{white}%~%f$terminfo[rc]%}[%F{yellow}%n%f]$p_branch$p_vimjob $p_mark "

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line
