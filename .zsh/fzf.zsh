# Default layout
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 70% --reverse'

#####################################################################
# fzf git
#####################################################################

# Move repository dir of ghq managenemt
function cd-fzf-ghqlist() {
    local GHQ_ROOT=`ghq root`
    local REPO=`ghq list -p | sed -e 's;'${GHQ_ROOT}/';;g' |fzf +m`
    if [ -n "${REPO}" ]; then
        local NAME=$(echo "${REPO}" | sed "s|${GHQ_ROOT}/||" | tr '/' '_' | tr . _)
        if tmux has-session -t "${NAME}" 2>/dev/null; then
            if [ -n "$TMUX" ]; then
                tmux switch-client -t "${NAME}"
            else
                tmux attach -t "${NAME}"
            fi
        else
            if [ -n "$TMUX" ]; then
                tmux new-session -ds "${NAME}" -c "${REPO}"
                tmux switch-client -t "${NAME}"
            else
                tmux new-session -s "${NAME}" -c "${REPO}"
            fi
        fi
    fi
}
zle -N cd-fzf-ghqlist

# Checkout git branch (including remote branches)
function checkout-fzf-gitbranch() {
    local GIT_BRANCH=$(git branch --sort=-authordate --all | grep -v HEAD | fzf +m)
    if [ -n "$GIT_BRANCH" ]; then
        git checkout $(echo "$GIT_BRANCH" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    fi
    zle accept-line
}
zle -N checkout-fzf-gitbranch

# Move worktree
function fzf-worktree() {
    # Format of `git worktree list`: path commit [branch]
    local selected_worktree=$(git worktree list | fzf \
        --prompt="worktrees > " \
        --header="Select a worktree to cd into" \
        --preview="echo '📦 Branch:' && git -C {1} branch --show-current && echo '' && echo '📝 Changed files:' && git -C {1} status --porcelain | head -10 && echo '' && echo '📚 Recent commits:' && git -C {1} log --oneline --decorate -10" \
        --reverse \
        --border \
        --ansi)

    if [ $? -ne 0 ]; then
        return 0
    fi

    if [ -n "$selected_worktree" ]; then
        local selected_path=${${(s: :)selected_worktree}[1]}

        if [ -d "$selected_path" ]; then
            if zle; then
                # Called from ZLE (keyboard shortcut)
                BUFFER="cd ${selected_path}"
                zle accept-line
            else
                # Called directly from command line
                cd "$selected_path"
            fi
        else
            echo "Directory not found: $selected_path"
            return 1
        fi
    fi

    # Only clear screen if ZLE is active
    if zle; then
        zle clear-screen
    fi
}
alias fwt=fzf-worktree

#####################################################################
# fzf ssh
#####################################################################

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

#####################################################################
# fzf file
#####################################################################

# Move to the selected directory from the results of find
cd-fzf-find() {
    local dir
    DIR=$(fd --hidden --type d 2> /dev/null | fzf +m --ansi --preview 'eza --long --all --icons --color=always {}')
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}
alias cdd=cd-fzf-find

# Open the selected file from the result of find in Vim
vim-fzf-find() {
    local FILE=$(fd --hidden --type f 2> /dev/null | fzf +m --ansi --preview 'bat -n --color=always {}')
    if [ -n "$FILE" ]; then
        ${EDITOR:-vim} $FILE
    fi
}
alias vimf=vim-fzf-find
