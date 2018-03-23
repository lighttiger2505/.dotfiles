autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -Uz colors; colors
autoload -Uz add-zsh-hook
autoload -Uz terminfo

setopt prompt_subst
setopt re_match_pcre

function current-git-branch() {
    echo -n "$(git rev-parse --abbrev-ref=loose HEAD 2> /dev/null)"
}

function python-version() {
    pv="PV:$(pyenv version-name) "
    vv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        vv="VV:$(basename ${VIRTUAL_ENV})"
    fi
    echo "${pv}${vv}"
}

terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
left_down_prompt_preexec() {
    print -rn -- $terminfo[el]
}
add-zsh-hook preexec left_down_prompt_preexec

function zle-keymap-select zle-line-init zle-line-finish
{
    case $KEYMAP in
        vicmd)
            vimmode="$fg[white]-- NORMAL --$reset_color"
            ;;
        main|viins)
            vimmode="$fg[blue]-- INSERT --$reset_color"
            ;;
        vivis)
            vimmode="$fg[blue]-- VISUAL --$reset_color"
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
