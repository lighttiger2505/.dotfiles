# Default layout
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'

# Move repository dir of ghq managenemt
function cd-fzf-ghqlist() {
    local GHQ_ROOT=`ghq root`
    local REPO=`ghq list -p | sed -e 's;'${GHQ_ROOT}/';;g' |fzf +m`
    if [ -n "${REPO}" ]; then
        BUFFER="cd ${GHQ_ROOT}/${REPO}"
    fi
    zle accept-line
}
zle -N cd-fzf-ghqlist
bindkey '^G' cd-fzf-ghqlist

# Checkout git branch (including remote branches)
function checkout-fzf-gitbranch() {
    local GIT_BRANCH=$(git branch --all | grep -v HEAD | fzf +m)
    if [ -n "$GIT_BRANCH" ]; then
        git checkout $(echo "$GIT_BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    fi
    zle accept-line
}
zle -N checkout-fzf-gitbranch
bindkey '^O' checkout-fzf-gitbranch

# Set prompt command history
function buffer-fzf-history() {
    local HISTORY=$(history -n -r 1 | fzf +m)
    BUFFER=$HISTORY
    if [ -n "$HISTORY" ]; then
        CURSOR=$#BUFFER
    else
        zle accept-line
    fi
}
zle -N buffer-fzf-history
bindkey '^R' buffer-fzf-history


# ssh selected host
function ssh-fzf-sshconfig() {
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
zle -N ssh-fzf-sshconfig
bindkey '^\' ssh-fzf-sshconfig
