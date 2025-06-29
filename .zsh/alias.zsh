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

# tig status
alias ts='tig status'

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

#####################################################################
# GitHub cli
#####################################################################
alias hb='gh repo view --web'
alias hp='gh pr view --web'
alias vimdiffpr='nvim -c ":OpenDiffviewPR"'

alias prcreate='gh pr create --template "pull_request_template.md"'

## Pull Request Review
alias prreview=github-pr-review
function github-pr-review() {
    local pr_url="$1"
    gh pr checkout ${pr_url}
    local branch=$(gh pr status --json baseRefName -q '.currentBranch.baseRefName')
    git fetch origin ${branch}:${branch}
    nvim -c ":OpenDiffviewPR"
}

# Create PR diff and review by CopilotChat
alias aireview=ai-review-github-pr
function ai-review-github-pr() {
    local tmpfile="/tmp/pr-diff-$(date +%s)"
    gh pr view --json url | jq .url | gh pr diff > ${tmpfile}
    nvim -c 'lua require("CopilotChat")' -c 'CopilotChatPullRequestReviewJa' ${tmpfile}
}

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
    nvim -c 'lua require("CopilotChat")' -c 'ObsidianNew'
}
alias on=obsidian-new
function obsidian-list-preview() {
    nvim -c 'lua require("CopilotChat")' -c 'ObsidianQuickSwitch'
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
