#####################################################################
# Change directory
#####################################################################

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias c="cd ~/"
alias dot="cd ~/.dotfiles"

#####################################################################
# Replace rust commands
#####################################################################

# cat to bat
if executable bat; then
    alias cat=bat
fi

# ls to eza
if executable eza; then
    alias ls=eza
    # show list all files
    alias ll="ls --long --all --icons"
    # show list order by newer files
    alias lr="ls --long --all --sort=modified --icons"
    # show tree all files
    alias lt="ls --long --all --tree --color=always | less --icons"
else
    # show list all files
    alias ll="ls -al"
    # show list order by newer files
    alias lr="ls -ltr"
fi

# diff to delta
if executable delta; then
    alias diff=delta
fi

# diff to delta
if executable zoxide; then
    alias z=cdi
fi

#####################################################################
# Git
#####################################################################
alias g="git"

# remove merged branch
alias rm-branch="git branch --merged | grep -v \\* | xargs -I % git branch -d %"
alias gp="git pull --prune --tags --all && rm-branch"

# merge develop branch
alias fdev="git fetch origin develop:develop"
alias rdev="git checkout develop && git pull origin develop && git rebase origin/develop"

# global alias for git branch
alias -g B='`git branch --all | grep -v HEAD | fzf -m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'

# git status
alias gs='git status'
alias ts='tig status'

function cd-git-worktree-fzf() {
  local dir
  dir=$(git worktree list | fzf | awk '$1=="*" {print $2; next} {print $1}')
  [ -n "$dir" ] && cd "$dir"
}
alias cdw=cd-git-worktree-fzf

#####################################################################
# Zsh
#####################################################################
# zshrc source
alias zs="source ~/.zshrc"

# zshrc load benchmark
alias zb="time ( zsh -i -c exit; )"

#####################################################################
# Vim
#####################################################################
# when not exist vim then start up vi
if executable vim; then
    alias vi=vim
else
    alias vim=vi
fi

# when not exist nvim then start up vim
if executable nvim; then
    alias vim=nvim
else
    alias nvim=vim
fi

alias vimdiff='vim -d'

# Open vim with tmux capture-pane
alias tm='tmux capture-pane -pS - > /tmp/tmux_output && vim /tmp/tmux_output'

# open vim with vimmemo
alias td='vim ~/.config/vimmemo/todo.md'
alias tl='vim ~/.config/vimmemo/link.md'
alias tf='vim ~/.config/vimmemo/feedback.md'

#####################################################################
# GitHub cli
#####################################################################
alias hb='gh repo view --branch "$(git branch --show-current)" --web'
alias hp='gh pr view --web'
alias ha='gh pr checks'
alias vimdiffpr='nvim -c ":OpenDiffviewPR"'

alias prcreate='gh pr create --template "pull_request_template.md"'

# Create PR diff and review by AI
function ai-review-github-pr() {
    local tmpfile="/tmp/pr-diff-$(date +%s)"
    gh pr view --json url | jq .url | gh pr diff > ${tmpfile}
    nvim -c 'lua require("codecompanion")' -c 'lua vim.cmd("CodeCompanion /custom_review_pull_request")' ${tmpfile}
}
alias airev=ai-review-github-pr

function get_repo_local_review_dir() {
    local repo="$1"

    local localDir
    case "$repo" in
        "MobilityTechnologies/kingston")
            localDir=~/dev/src/github.com/MobilityTechnologies/kingston-worktree/kingston-review
            ;;
        "MobilityTechnologies/kingston-static")
            localDir=~/dev/src/github.com/MobilityTechnologies/kingston-static-worktree/kingston-static-review
            ;;
        *)
            echo "Error: No local mapping for repository '$repo'" >&2
            return 1
            ;;
    esac

    if [[ ! -d $localDir ]]; then
        echo "Error: Directory '$localDir' does not exist." >&2
        return 1
    fi

    echo "$localDir"
    return 0
}

function github-pr-review-fzf() {
    local selected=$(
        gh pr list \
            --search "org:MobilityTechnologies review-requested:@me -label:dependencies sort:updated-desc" \
            --json number,headRepositoryOwner,headRepository,title,updatedAt,reviewRequests \
            --jq '
                .[] 
                | select(any(.reviewRequests[]; .login == "lighttiger2505")) 
                | "\(.number)\t\(.headRepositoryOwner.login)/\(.headRepository.name)\t\(.title)\t\(.updatedAt)"
            ' \
            | fzf --reverse --prompt='Select PR> '
    )
    [[ -z $selected ]] && return 0

    local prNum=$(awk -F'\t' '{print $1}' <<<"$selected")   # number
    local repo=$(awk -F'\t' '{print $2}' <<<"$selected")    # REPO
    local localDir=$(get_repo_local_review_dir "$repo")
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    cd "$localDir" || return 1

    gh pr checkout "$prNum"
    local baseBranch=$(gh pr status --json baseRefName -q '.currentBranch.baseRefName')
    git fetch origin "$baseBranch":"$baseBranch"
    gh pr view --web "$prNum"
    nvim -c ":OpenDiffviewPR"
}
alias prrevf=github-pr-review-fzf

function github-pr-review-url() {
    local pr_url="$1"
    if [ -z "$pr_url" ]; then
        echo "Usage: $0 <github-pull-request-url>"
        exit 1
    fi
    local repo="$(echo "$pr_url" | cut -d/ -f4-5)"
    local prNum="$(basename "$pr_url")"
    local localDir=$(get_repo_local_review_dir "$repo")
    if [[ $? -ne 0 ]]; then
        return 1
    fi
    cd "$localDir" || return 1

    gh pr checkout "$prNum"
    local baseBranch=$(gh pr status --json baseRefName -q '.currentBranch.baseRefName')
    git fetch origin "$baseBranch":"$baseBranch"
    nvim -c ":OpenDiffviewPR"
}
alias prrevu=github-pr-review-url

function get_repo_local_dir() {
    local repo="$1"

    local localDir
    case "$repo" in
        "MobilityTechnologies/kingston")
            localDir=~/dev/src/github.com/MobilityTechnologies/kingston
            ;;
        "MobilityTechnologies/kingston-static")
            localDir=~/dev/src/github.com/MobilityTechnologies/kingston-static
            ;;
        *)
            echo "Error: No local mapping for repository '$repo'" >&2
            return 1
            ;;
    esac

    if [[ ! -d $localDir ]]; then
        echo "Error: Directory '$localDir' does not exist." >&2
        return 1
    fi

    echo "$localDir"
    return 0
}

function github-pr-switch-fzf() {
    local selected=$(
        gh pr list \
            --search "org:MobilityTechnologies is:open author:@me -label:dependencies sort:updated-desc" \
            --json number,headRepositoryOwner,headRepository,headRefName,title,updatedAt \
            --jq '.[] | "\(.number)\t\(.headRepositoryOwner.login)/\(.headRepository.name)\t\(.headRefName)\t\(.title)\t\(.updatedAt)"' \
            | fzf --reverse --prompt='Select PR> '
    )
    [[ -z $selected ]] && return 0

    local prNum=$(awk -F'\t' '{print $1}' <<<"$selected")
    local repo=$(awk -F'\t' '{print $2}' <<<"$selected")
    local branch=$(awk -F'\t' '{print $3}' <<<"$selected")
    local localDir=$(get_repo_local_dir "$repo")
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    cd "$localDir" || return 1
    git switch $branch
}
alias prsif=github-pr-switch-fzf

github-pr-list-markdown() {
  gh pr list \
    --search "org:MobilityTechnologies is:open author:@me -label:dependencies sort:updated-desc" \
    --json title,headRefName,url,headRepository,isDraft \
    --template '{{range .}}- [{{if .isDraft}}(Draft) {{end}}{{.headRepository.name}} {{.headRefName}} {{.title}}]({{.url}})
{{end}}'
}
alias prmd=github-pr-list-markdown

function list-copilot-models() {
    curl -s \
        -H "Authorization: Bearer $(gh auth token)" \
        https://api.githubcopilot.com/models \
        | jq '.data[] | "\(.id): \(.name)"'
}
alias copilotmodels=list-copilot-models
#####################################################################
# liary
#####################################################################
alias li='liary'
alias cdl='cd `liary config --get diarydir`'

#####################################################################
# Draw.io
#####################################################################
function open-tmp-drawfile() {
  local tmpfile="${HOME}/vscode/drawmemo/$(date +'%Y%m%d').drawio"
  touch ${tmpfile}
  code ${tmpfile}
}
alias drawio=open-tmp-drawfile

#####################################################################
# fibonacci
#####################################################################
function draw-fibonacci() {
    m=0
    n=1
    num=8

    (( num +=2 ))

    for i in $(seq 1 $num)
    do
        (( o = $m + $n ))
        echo $o
        m=$n
        n=$o
    done
}
alias fib=draw-fibonacci

#####################################################################
# Obsidian
#####################################################################
function obsidian-new() {
    nvim -c 'lua require("obsidian")' -c 'ObsidianNew'
}
alias on=obsidian-new
function obsidian-list-preview() {
    nvim -c 'lua require("obsidian")' -c 'ObsidianQuickSwitch'
}
alias ov=obsidian-list-preview

fzf_alias_exec() {
  local selected=$(alias | fzf)
  [[ -z $selected ]] && return
  selected=${selected#alias }
  local name=${selected%%=*}
  eval "$name"
}
alias al='fzf_alias_exec'

#####################################################################
# Claude Code
#####################################################################
alias cc='claude'
alias devc='devcontainer'
alias devclaude='devcontainer up --workspace-folder . && devcontainer exec --workspace-folder . claude'
alias devzsh='devcontainer up --workspace-folder . && devcontainer exec --workspace-folder . zsh'
alias devrec='devcontainer up --workspace-folder . --remove-existing-container'
alias brmodels='aws bedrock list-inference-profiles --profile mot-sandbox-software-dev-aws_llm-trial-emp-ro --region ap-northeast-1 | jq ".inferenceProfileSummaries.[] | [.inferenceProfileName, .inferenceProfileArn] | @csv"'
alias ccb='AWS_PROFILE="mot-sandbox-software-dev-aws_llm-trial-emp-ro" \
CLAUDE_CODE_USE_BEDROCK="1" \
AWS_REGION="ap-northeast-1" \
ANTHROPIC_MODEL="opusplan" \
ANTHROPIC_DEFAULT_HAIKU_MODEL="jp.anthropic.claude-sonnet-4-5-20250929-v1:0" \
ANTHROPIC_DEFAULT_SONNET_MODEL="jp.anthropic.claude-sonnet-4-5-20250929-v1:0" \
ANTHROPIC_DEFAULT_OPUS_MODEL="global.anthropic.claude-opus-4-6-v1" \
claude code'
alias lboxauth='aws sso login --profile mot-sandbox-software-dev-aws_llm-trial-emp-ro'
alias lboxup='lbox update-env'
alias lboxcc='lbox exec sandbox claude'
alias lboxsh='lbox exec sandbox zsh'
alias planv='nvim "$(eza -s modified ~/.claude/plans | head -n 1)"'

function edit-claude-settings() {
    local files=(
        "$HOME/.claude/settings.json"
        ".claude/settings.json"
        ".claude/settings.local.json"
    )
    selected=$(printf "%s\n" "${files[@]}" | xargs -I{} sh -c "[ -f {} ] && echo {}" \
        | fzf --preview "sed -n \"1,200p\" {}")
    [ -n "$selected" ] && ${EDITOR:-nvim} "$selected"
}
alias cccon=edit-claude-settings

#####################################################################
# Process management
#####################################################################
function kill-process-fzf() {
    local PROCESS=$(ps aux | sed 1d | fzf --multi --header --reverse)
    if [[ -n "$PROCESS" ]]; then
        echo "$PROCESS" | awk '{print $2}' | xargs -r kill
    fi
}
alias pkf=kill-process-fzf

#####################################################################
# Mac Utilities
#####################################################################
alias stopsleep='caffeinate -i -d'
