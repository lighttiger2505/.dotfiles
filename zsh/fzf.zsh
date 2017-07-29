# Checkout git branch (including remote branches)
fzf-git-branch-checkout() {
    local BRANCHES BRANCH
    BRANCHES=`git branch --all | grep -v HEAD`
    BRANCH=`echo "$BRANCHES" | fzf -d $(( 2 + $(wc -l <<< "$BRANCHES") )) +m`
    if [ -n "$BRANCH" ]; then
        git checkout $(echo "$BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        zle accept-line
    fi
}
zle -N fzf-git-branch-checkout


# Set prompt command history
function fzf-cmd-history() {
    local HISTORY=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf +m`
    BUFFER=$HISTORY
    CURSOR=$#BUFFER
}
zle -N fzf-cmd-history


# Move repository dir of ghq managenemt
function fzf-ghq=repository() {
    local REPO=`ghq list -p | fzf +m`
    if [ -n "$REPO" ]; then
        BUFFER="cd $REPO"
        zle accept-line
    fi
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
    zle accept-line
  fi
}
zle -N fzf-ssh-host
