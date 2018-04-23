# Default layout
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

alias -g B='`git branch --all | grep -v HEAD | fzf -m`'

# Checkout git branch (including remote branches)
fzf-git-branch-checkout() {
    local BRANCHES BRANCH
    BRANCHES=`git branch --all | grep -v HEAD`
    BRANCH=`echo "$BRANCHES" | fzf -d $(( 2 + $(wc -l <<< "$BRANCHES") )) +m`
    if [ -n "$BRANCH" ]; then
        git checkout $(echo "$BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    fi
    zle accept-line
}
zle -N fzf-git-branch-checkout


# Set prompt command history
function fzf-cmd-history() {
    local HISTORY=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf +m`
    BUFFER=$HISTORY
    if [ -n "$HISTORY" ]; then
        CURSOR=$#BUFFER
    else
        zle accept-line
    fi
}
zle -N fzf-cmd-history


# Move repository dir of ghq managenemt
function fzf-ghq=repository() {
    local GHQ_ROOT=`ghq root`
    local REPO=`ghq list -p | sed -e 's;'${GHQ_ROOT}/';;g' |fzf +m`
    if [ -n "${REPO}" ]; then
        BUFFER="cd ${GHQ_ROOT}/${REPO}"
    fi
    zle accept-line
}
zle -N fzf-ghq=repository


# ssh selected host
function fzf-ssh-host() {
    local SSH_HOST=$(awk '
        tolower($1)=="host" {
            for (i=2; i<=NF; i++) {
                if ($i !~ "[*?]") {
                    print $i
                }
            }
        }
    ' ~/.ssh/config | sort | fzf +m)
    if [ -n "$SSH_HOST" ]; then
        BUFFER="ssh $SSH_HOST"
    fi
    zle accept-line
}
zle -N fzf-ssh-host

# open file with editor
fzf-vim-open-file() {
    local FILE=$(find `pwd` -not \( \
        -name .svn \
        -prune -o -name .git \
        -prune -o -name CVS \
        -prune \
    \) | fzf +m)
    [[ -n "$FILE" ]] && ${EDITOR:-vim} "${files[@]}"
    if [ -n "$FILE" ]; then
        BUFFER="${EDITOR:-vim} $FILE"
    fi
    zle accept-line
}
zle -N fzf-vim-open-file
