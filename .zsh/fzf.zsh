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
        local NAME=$(echo "${REPO}" | tr '/' '_' | tr . _)
        if tmux has-session -t "${NAME}" 2>/dev/null; then
            if [ -n "$TMUX" ]; then
                tmux switch-client -t "${NAME}"
            else
                tmux attach -t "${NAME}"
            fi
        else
            local REPO_PATH=${GHQ_ROOT}/${REPO}
            if [ -n "$TMUX" ]; then
                tmux new-session -ds "${NAME}" -c "${REPO_PATH}"
                tmux switch-client -t "${NAME}"
            else
                tmux new-session -s "${NAME}" -c "${REPO_PATH}"
            fi
        fi
    fi
}
zle -N cd-fzf-ghqlist

# Look up existing worktree path for a given branch (refs/heads/xxx -> path)
_git_worktree_path_for_branch() {
  local b="$1"
  local ref="refs/heads/$b"

  git worktree list --porcelain \
  | awk -v ref="$ref" '
      $1=="worktree" { wt=$2 }
      $1=="branch"   { br=$2; if (br==ref) { print wt; exit } }
    '
}

# Normalize fzf selection to a branch name (remotes/origin/foo -> foo)
_git_normalize_branch_name() {
  sed -E 's#^[* ]+##; s#^remotes/[^/]+/##; s#^refs/heads/##'
}

function checkout-fzf-gitbranch() {
  local SELECTED_BRANCH=$(git branch --sort=-authordate --all | grep -v HEAD | fzf +m)
  local BRANCH="$(echo "${SELECTED_BRANCH}" | _git_normalize_branch_name)"
  [[ -z "${BRANCH}" ]] && return 0

  # If a worktree already exists for this branch, cd into it instead of checkout
  local WT_PATH="$(_git_worktree_path_for_branch "${BRANCH}")"
  if [[ -n "${WT_PATH}" ]]; then
    cd "${WT_PATH}"
    return 0
  fi

  # No worktree found; just switch (prefer switch over checkout)
  git switch "${BRANCH}" 2>/dev/null && return 0

  # Remote-only branch: create a tracking branch and switch
  git switch -c "${BRANCH}" --track "origin/${BRANCH}"
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
