#####################################################################
# Utility functions
#####################################################################
executable() {
    type "$1" &> /dev/null ;
}

#####################################################################
# Utils
#####################################################################

# Alias reminder
alias fal='alias| sed "s/=/\t/" | fzf'

# cd util
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias c="cd ~/"
alias dot="cd ~/.dotfiles"
alias pack="cd ~/.local/share/nvim/site/pack/packer/start/packer.nvim"

alias vimrc="vim ~/init.lua"

alias pd="pwd | pbcopy"
alias untar='tar -zxvf'
alias gip='curl inet-ip.info'
alias pass='vim ~/secrets/pass.md'

# Move to the selected directory from the results of find
cd-fzf-find() {
    local dir
    DIR=$(fd --hidden --type d 2> /dev/null | fzf +m --ansi --preview 'exa --long --all --icons --color=always {}')
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

# less
export LESS='--RAW-CONTROL-CHARS'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

#####################################################################
# Replace lagasy command
#####################################################################

# cat to bat
if executable bat; then
    alias cat=bat
fi

# ls to exa
if executable exa; then
    alias ls=exa
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
# git status
alias gs="git status"

# git diff
alias gd="git diff"
alias gdc="git diff --cached "

# git log
alias gl="git log"
alias glogn="git log --oneline --graph -n10"

# remove merged branch
alias rm-branch="git branch --merged | grep -v \\* | xargs -I % git branch -d %"
alias gf="git fetch --prune --tags --all && rm-branch"
alias gp="git pull --prune --tags --all && rm-branch"

# Select git branch
alias -g B='`git branch --all | grep -v HEAD | fzf -m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'

# tig status
# alias ts='tmux popup -xC -yC -w90% -h90% -E -d "#{pane_current_path}" "tig status"'
alias ts='tig status'

# Setting git local config
alias gitlocal='git config --local user.name "lighttiger2505";git config --local user.email "lighttiger2505@gmail.com"'

# lazygit shortcut
alias lg='lazygit'

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
if type vim > /dev/null 2>&1; then
    alias vi=vim
else
    alias vim=vi
fi

# when not exist nvim then start up vim
if type nvim > /dev/null 2>&1; then
    alias vim=nvim
else
    alias nvim=vim
fi

# Launch Vim shortcuts
alias v='vim'
alias vi='vim'
alias vimdiff='vim -d'
alias dvim='/usr/bin/vim -u ~/.dev_vimrc'
alias dvim-lsp-deoplete='nvim -u ~/.vim/dev/vim-lsp-deoplete.vim'
alias dvim-lsp-asyncomplete='nvim -u ~/.vim/dev/vim-lsp-asyncomplete.vim'
alias coc='nvim -u ~/.vim/dev/coc.vim'
alias nvimlsp='nvim -u ~/.vim/dev/nvim-lsp.vim'

# Update vim plugins use vim
#dein#update()
alias upvplug='vim -c "call dein#check_update(v:true)" -c "q!"'

#####################################################################
# lab
#####################################################################
# Browse selected issue
lab_browse_issue() {
    LAB_ISSUE=`lab issue --num=100 | fzf -m | awk '{print $1}'`
    if [ -n "${LAB_ISSUE}" ]; then
        lab browse -s issues/${LAB_ISSUE}
    fi
}

# Browse selected issue all repository
lab_browse_issue_all_assinee_me() {
    LAB_ISSUE=`lab issue --num=20 --all-project --opened --assigned-me | fzf -m | awk '{print $1,$2}'`
    if [ -n "${LAB_ISSUE}" ]; then
        PRJ=`echo ${LAB_ISSUE} | awk '{print $1}'`
        NO=`echo ${LAB_ISSUE} | awk '{print $2}'`
        lab browse --project ${PRJ} -s issues/${NO}
    fi
}

# Browse selected issue all repository
lab_browse_issue_all_created_me() {
    LAB_ISSUE=`lab issue --num=20 --all-project --opened --created-me | fzf -m | awk '{print $1,$2}'`
    if [ -n "${LAB_ISSUE}" ]; then
        PRJ=`echo ${LAB_ISSUE} | awk '{print $1}'`
        NO=`echo ${LAB_ISSUE} | awk '{print $2}'`
        lab browse --project ${PRJ} -s issues/${NO}
    fi
}

# Browse selected merge request
lab_browse_merge_request() {
    LAB_MR=`lab merge-request --num=100 | fzf -m | awk '{print $1}'`
    if [ -n "${LAB_MR}" ]; then
        lab browse -s merge_requests/${LAB_MR}
    fi
}

# Browse selected issue all repository
lab_browse_merge_request_all_assinee_me() {
    LAB_ISSUE=`lab merge-request --all-project --assigned-me --opened | fzf -m | awk '{print $1,$2}'`
    if [ -n "${LAB_ISSUE}" ]; then
        PRJ=`echo ${LAB_ISSUE} | awk '{print $1}'`
        NO=`echo ${LAB_ISSUE} | awk '{print $2}'`
        lab browse --project ${PRJ} -s merge_requests/${NO}
    fi
}

# Browse selected issue all repository
lab_browse_merge_request_all_created_me() {
    LAB_ISSUE=`lab merge-request --all-project --created-me --opened | fzf -m | awk '{print $1,$2}'`
    if [ -n "${LAB_ISSUE}" ]; then
        PRJ=`echo ${LAB_ISSUE} | awk '{print $1}'`
        NO=`echo ${LAB_ISSUE} | awk '{print $2}'`
        lab browse --project ${PRJ} -s merge_requests/${NO}
    fi
}

# lab shortcut
alias lb='lab browse'
alias lbif=lab_browse_issue
alias lbifa=lab_browse_issue_all_assinee_me
alias lbifc=lab_browse_issue_all_created_me
alias lbmf=lab_browse_merge_request
alias lbmfa=lab_browse_merge_request_all_assinee_me
alias lbmfc=lab_browse_merge_request_all_created_me

#####################################################################
# awscli
#####################################################################
# aws profile select
alias ap='export AWS_DEFAULT_PROFILE=`cat ~/.aws/credentials | grep -e "\[\(.*\)\]" | sed -e "s/\[//g" | sed -e "s/\]//g" | sort | fzf`'
# aws ec2 ip list
alias ec2='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.Tags!=null) | [.InstanceId, .InstanceType, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2ac='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.State.Name == \"running\") | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2st='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.State.Name == \"stopped\") | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2desc='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"i-017b9946a248a7679\")"'
alias elbs='aws elb describe-load-balancers | jq -r ".LoadBalancerDescriptions[].LoadBalancerArn"'
alias albs='aws elbv2 describe-load-balancers | jq -r ".LoadBalancers[].LoadBalancerName"'
alias tgs='aws elbv2 describe-target-groups | jq -r ".TargetGroups[].TargetGroupName"'
alias ags='aws autoscaling describe-auto-scaling-groups | jq -r ".AutoScalingGroups[].AutoScalingGroupName"'

alias amis='aws ec2 describe-images --owners self amazon | jq -r ".Images[] | [.ImageId, .CreationDate, .Name, .Architecture] | @tsv"'

#####################################################################
# awslogs
#####################################################################

awslogs-select-and-tail() {
    local LOG_GROUP=`awslogs groups | fzf -m`
    if [ -n "${LOG_GROUP}" ]; then
        print -z "utern ${LOG_GROUP}"
    fi
}
alias logs=awslogs-select-and-tail

#####################################################################
# ecscli
#####################################################################
alias ecs='ecs-cli'

ecs-cluster-select() {
    ECS_CLUSTER=`cat ~/.ecs/config | yq -r '."clusters" | keys[]' | fzf -m`
    if [ -n "${ECS_CLUSTER}" ]; then
        ecs-cli configure default --config-name ${ECS_CLUSTER}
    fi
}
alias ecsc=ecs-cluster-select

ecs-log-running() {
    TASK_HASH=$(ecs-cli ps | grep -v "STOPPED" | fzf -m | awk '{print $1}')
    if [ -n "${TASK_HASH}" ]; then
        ecs-cli logs --task-id ${TASK_HASH%/*} --follow
    fi
}
alias ecslr=ecs-log-running

ecs-log-stopped() {
    TASK_HASH=$(ecs-cli ps | grep "STOPPED" | fzf -m | awk '{print $1}')
    if [ -n "${TASK_HASH}" ]; then
        ecs-cli logs --task-id ${TASK_HASH%/*}
    fi
}
alias ecsls=ecs-log-stopped


#####################################################################
# todoist
#####################################################################
if type todoist > /dev/null 2>&1; then
    # Cmd shutcut
    alias to='todoist'
    # Select todo key
    alias -g T='`todoist list | fzf -m | awk '\''{print $1}'\''`'
fi

#####################################################################
# GitHub cli
#####################################################################
alias hb='gh repo view --web'
alias hbp='gh pr view --web'
alias hci='gh workflow view --web'

#####################################################################
# ripgrep
#####################################################################
alias rg='rg --hidden'

#####################################################################
# tmux
#####################################################################
alias tl="tmux ls"
alias ta="tmux attach -t "
alias tk="tmux kill-session -t "
alias tn="tmux new -s "
alias td="tmux detach"

if [ "Linux" = "$(uname -s)" ]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
    alias open=xdg-open
fi

#####################################################################
# Docker
#####################################################################
# Display continer environment
alias denv="docker inspect --format='{{range .Config.Env}}{{println .}}{{end}}' "

# Display continer IP
alias dip="docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "

alias dc="docker-compose"

#####################################################################
# liary
#####################################################################
alias li='liary'
alias cdl='cd `liary config --get diarydir`'

#####################################################################
# gcloud
#####################################################################

gcloud-change-config() {
    local CONFIG=`gcloud config configurations list | awk 'NR > 1 {print}' | awk '{print $1}' | fzf -m`
    if [ -n "${CONFIG}" ]; then
        gcloud config configurations activate ${CONFIG}
    fi
}
alias gccc=gcloud-change-config

gcloud-browse-app-version() {
    local CHOICE_LINE=`gcloud app versions list -s ope | awk 'NR > 1 {print}' | awk '{print $1, $2}' | fzf -m`
    if [ -n "${CHOICE_LINE}" ]; then
        local APP=`echo ${CHOICE_LINE} | awk '{print $1}'`
        local VERSION=`echo ${CHOICE_LINE} | awk '{print $2}'`
        gcloud app browse --service=${APP} --version=${VERSION}
    fi
}
alias gcab=gcloud-browse-app-version

gcloud-logs-app-version() {
    local CHOICE_LINE=`gcloud app versions list -s ope | awk 'NR > 1 {print}' | awk '{print $1, $2}' | fzf -m`
    if [ -n "${CHOICE_LINE}" ]; then
        local APP=`echo ${CHOICE_LINE} | awk '{print $1}'`
        local VERSION=`echo ${CHOICE_LINE} | awk '{print $2}'`
        gcloud app logs tail --service=${APP} --version=${VERSION}
    fi
}
alias gcal=gcloud-logs-app-version

gcloud-compute-ssh() {
    CHOICE_LINE=`gcloud compute instances list | fzf -m`
    if [ -n "${CHOICE_LINE}" ]; then
        NAME=`echo ${CHOICE_LINE} | awk '{print $1}'`
        ZONE=`echo ${CHOICE_LINE} | awk '{print $2}'`
        gcloud compute ssh --zone ${ZONE} ${NAME}
    fi
}
alias gcssh=gcloud-compute-ssh

#####################################################################
# go module
#####################################################################

alias goplsup='go install golang.org/x/tools/gopls@latest'

#####################################################################
# Pomodoro
#####################################################################

alias worktime='~/.tmux/timer.sh 25'
alias breaktime='~/.tmux/timer.sh 5'

#####################################################################
# Benchmarks
#####################################################################
# zsh benchmark
function zsh-startuptime() {
  local total_msec=0
  local msec
  local i
  for i in $(seq 1 10); do
    msec=$(TIMEFMT='%mE'; time zsh -i -c exit)
    msec=$(echo $msec | tr -d "ms")
    echo "${(l:2:)i}: ${msec} [ms]"
    total_msec=$(( $total_msec + $msec ))
  done
  local average_msec
  average_msec=$(( ${total_msec} / 10 ))
  echo "\naverage: ${average_msec} [ms]"
}
alias zbench=zsh-startuptime

# zsh profiling
function zsh-profiler() {
  ZSHRC_PROFILE=1 zsh -i -c zprof
}
alias zprofile=zsh-profiler

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
# Util
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

alias todo='vim ~/.config/todo/todo.md'
