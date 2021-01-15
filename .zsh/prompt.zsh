autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
autoload -Uz colors; colors

setopt prompt_subst
setopt re_match_pcre

function current-git-branch() {
    echo -n "$(git rev-parse --abbrev-ref=loose HEAD 2> /dev/null)"
}

function zle-line-init zle-line-finish
{
    p_cdr="%F{cyan}%~%f"
    p_vimjob="%F{green}$([[ $(jobs|grep -c vim) != 0 ]] && print "vim:$(jobs|grep -c vim) ")%f"
    p_branch="%F{magenta}$(current-git-branch)%f"
    p_user="%F{yellow}%n%f"
    p_mark="%B%(?,%F{green},%F{red})%(!,#,$)%f%b"
    PROMPT="(${p_user}) > {${p_cdr}}[${p_branch}]
${p_vimjob}${p_mark} "

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
