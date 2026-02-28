# Default layout
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 70% --reverse'

#####################################################################
# fzf git
#####################################################################

# Select ghq repository with fzf
# Sets _GHQ_ROOT and _GHQ_REPO variables
function _fzf-select-ghq-repo() {
    _GHQ_ROOT=`ghq root`
    _GHQ_REPO=$(ghq list -p | sed -e 's;'${_GHQ_ROOT}/';;g' | fzf +m \
      --prompt="repositories > " \
      --preview="dir='${_GHQ_ROOT}/{}'; f=\$(ls \"\$dir\"/README* 2>/dev/null | head -1); if [ -n \"\$f\" ]; then bat --style=plain --color=always \"\$f\" 2>/dev/null || cat \"\$f\"; else echo 'No README found'; fi"
    )
    [[ -n "${_GHQ_REPO}" ]]
}

# Move repository dir with tmux session management
function create-repository-session() {
    _fzf-select-ghq-repo || return
    local NAME=$(echo "${_GHQ_REPO#*/}" | tr '/' '_' | tr . _)
    local REPO_PATH=${_GHQ_ROOT}/${_GHQ_REPO}
    if tmux has-session -t "${NAME}" 2>/dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "${NAME}"
        else
            tmux attach -t "${NAME}"
        fi
        local CURRENT_PATH=$(tmux display-message -t "${NAME}" -p "#{pane_current_path}")
        if [ "${CURRENT_PATH}" != "${REPO_PATH}" ]; then
            tmux send-keys -t "${NAME}" "cd ${REPO_PATH}" Enter
        fi
    else
        if [ -n "$TMUX" ]; then
            tmux new-session -ds "${NAME}" -c "${REPO_PATH}"
            tmux switch-client -t "${NAME}"
        else
            tmux new-session -s "${NAME}" -c "${REPO_PATH}"
        fi
    fi

    if zle; then
        zle clear-screen
    fi
}
alias gcs=create-repository-session

# Move repository dir (simple cd)
function cd-git-repository() {
    _fzf-select-ghq-repo || return
    cd "${_GHQ_ROOT}/${_GHQ_REPO}"
}
alias cdr=cd-git-repository

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
  sed -E 's#^[*+ ]+##; s#^remotes/[^/]+/##; s#^refs/heads/##'
}

function switch-git-branch() {
  local SELECTED_BRANCH=$(git branch --sort=-authordate --all | grep -v HEAD | fzf +m \
    --prompt="branches > " \
    --preview="echo '📚 Recent commits:' && git log --oneline --decorate -10 {1} && echo '' && echo '📊 Diff from HEAD:' && git diff --stat HEAD...{1} 2>/dev/null | tail -5" \
    )
  local BRANCH="$(echo "${SELECTED_BRANCH}" | _git_normalize_branch_name)"

  if [[ -n "${BRANCH}" ]]; then
    local WT_PATH="$(_git_worktree_path_for_branch "${BRANCH}")"
    if [[ -n "${WT_PATH}" ]]; then
      cd "${WT_PATH}"
    else
      git switch "${BRANCH}"
    fi
  fi
}
alias sg=switch-git-branch

# Move worktree
function cd-git-worktree() {
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
}
alias cdw=cd-git-worktree

function switch-repository-session() {
  [ -n "$TMUX" ] || return
  SELECTED="$(tmux list-sessions | fzf | cut -d : -f 1)"
  if [ -n "$SELECTED" ]; then
    tmux switch -t $SELECTED
  fi
}
alias ss=switch-repository-session

# Select and run a git fzf command
function select-git-command() {
    local commands=(
        "cd-git-repository:(cdr):Git Repositoryへ移動"
        "cd-git-worktree:(cdw):Git Worktreeを移動",
        "switch-git-branch:(sg):Git Branchを切り替え",
        "create-repository-session:(cs):Git Repositoryのtmuxセッションを作成"
        "switch-repository-session:(ss):Git Repositoryのtmuxセッションを切り替え"
    )
    local selected=$(printf '%s\n' "${commands[@]}" | fzf +m \
        --prompt="git commands > " \
        --delimiter=":" \
        --with-nth=1.. \
    )
    if [[ -n "${selected}" ]]; then
        local cmd="${selected%%:*}"
        ${cmd}
    fi
}
alias gj=select-git-command
