#####################################################################
# Utils
#####################################################################
alias ll="ls -al"
alias lr="ls -ltr"
alias dot="cd ~/.dotfiles"
alias pd="pwd | pbcopy"
alias c='clear'
alias untar='tar -zxvf'
alias gip='curl inet-ip.info'
alias pass='cat ~/.dotiridge/password/passwd'

cd-fzf-find() {
    local dir
    DIR=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | fzf +m)
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}
alias fd=cd-fzf-find

vim-fzf-find() {
    local FILE=$(find ./ -path '*/\.*' -name .git -prune -o -type f -print 2> /dev/null | fzf +m)
    if [ -n "$FILE" ]; then
        ${EDITOR:-vim} $FILE
    fi
}
alias fv=vim-fzf-find

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
alias gf="git fetch -p && rm-branch"
alias gp="git pull -p && rm-branch"

# Select git branch
alias -g B='`git branch --all | grep -v HEAD | fzf -m | sed "s/.* //" | sed "s#remotes/[^/]*/##"`'

# tig status
alias ts="tig status"

# Setting git local config
alias gitlocal='git config --local user.name "lighttiger2505";git config --local user.email "lighttiger2505@gmail.com"'

#####################################################################
# Zsh
#####################################################################
# zshrc source
alias zs="source ~/.zshrc"

# zshrc load benchmark
alias zb="time ( zsh -i -c exit; )"

alias al="alacritty"

#####################################################################
# Vim
#####################################################################
# Vim shotchut
alias v=vim

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

alias vimdiff='vim -d'
alias vimdev='vim -u ~/.dev_vimrc'

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

# Browse selected issue
lab_browse_issue_me() {
    LAB_ISSUE=`lab issue --num=20 --assigned-me | fzf -m | awk '{print $1}'`
    if [ -n "${LAB_ISSUE}" ]; then
        lab browse -s issues/${LAB_ISSUE}
    fi
}

# Browse selected issue all repository
lab_browse_issue_all() {
    LAB_ISSUE=`lab issue --num=20 --all-project --opened --assigned-me | fzf -m | awk '{print $1,$2}'`
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

lab_browse_merge_request_me() {
    LAB_MR=`lab merge-request --num=20 --assigned-me --opened | fzf -m | awk '{print $1}'`
    if [ -n "${LAB_MR}" ]; then
        lab browse -s merge_requests/${LAB_MR}
    fi
}

# Browse selected issue all repository
lab_browse_merge_request_all() {
    LAB_ISSUE=`lab merge-request --all-project --assigned-me --opened | fzf -m | awk '{print $1,$2}'`
    if [ -n "${LAB_ISSUE}" ]; then
        PRJ=`echo ${LAB_ISSUE} | awk '{print $1}'`
        NO=`echo ${LAB_ISSUE} | awk '{print $2}'`
        lab browse --project ${PRJ} -s merge_requests/${NO}
    fi
}

# lab shortcut
alias lb='lab browse'
alias lbif=lab_browse_issue
alias lbifm=lab_browse_issue_me
alias lbifa=lab_browse_issue_all
alias lbmf=lab_browse_merge_request
alias lbmfm=lab_browse_merge_request_me
alias lbmfa=lab_browse_merge_request_all

#####################################################################
# awscli
#####################################################################
# aws profile select
alias ap='export AWS_DEFAULT_PROFILE=`cat ~/.aws/credentials | grep -e "\[\(.*\)\]" | sed -e "s/\[//g" | sed -e "s/\]//g" | sort | fzf`'
# aws ec2 ip list
alias ec2='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2ac='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.State.Name == \"running\") | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2st='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.State.Name == \"stopped\") | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
alias ec2desc='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.InstanceId==\"i-017b9946a248a7679\")"'
alias elb='aws elb describe-load-balancers | jq -r ".LoadBalancerDescriptions[].LoadBalancerName"'

#####################################################################
# awslogs
#####################################################################
awslogs-select() {
    LOG_GROUP=`awslogs groups | fzf -m`
    if [ -n "${LOG_GROUP}" ]; then
        awslogs get ${LOG_GROUP}
    fi
}
alias logs=awslogs-select

awslogs-select-tail() {
    LOG_GROUP=`awslogs groups | fzf -m`
    if [ -n "${LOG_GROUP}" ]; then
        awslogs get ${LOG_GROUP} --watch
    fi
}
alias logst=awslogs-select-tail

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
# hub
#####################################################################
alias hb='hub browse'

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

#####################################################################
# liary
#####################################################################
liary_file_open() {
    LIARY=`liary -l | sort --reverse | fzf -m`
    if [ -n "${LIARY}" ]; then
        vim ${LIARY}
    fi
}
alias ryo=liary_file_open

# Benchmark
alias zbench='for i in $(seq 1 10); do time zsh -i -c exit; done'

#####################################################################
# browser-hb
#####################################################################

browser-history() {
    HISTORY=`bhb history | fzf -m | sed 's#.*\(https*://\)#\1#'`
    if [ -n "${HISTORY}" ]; then
        open ${HISTORY}
    fi
}
alias bh=browser-history

browser-bookmark() {
    BOOKMARK=`bhb bookmark | fzf -m | sed 's#.*\(https*://\)#\1#'`
    if [ -n "${BOOKMARK}" ]; then
        open ${BOOKMARK}
    fi
}
alias bb=browser-bookmark

#####################################################################
# zsh-marks
#####################################################################

alias bs="bookmark"
alias bd="deletemark"
alias bl="showmarks"

fzf-jump-bookmark() {
    BOOKMARK=`showmarks | sort | fzf -m | awk '{print $1}'`
    if [ -n "${BOOKMARK}" ]; then
        jump ${BOOKMARK}
    fi
}
alias b=fzf-jump-bookmark

#####################################################################
# gcloud
#####################################################################

gcloud-change-project() {
    PROJECT=`gcloud projects list | fzf -m | awk '{print $1}'`
    if [ -n "${PROJECT}" ]; then
        gcloud config set project ${PROJECT}
    fi
}
alias gccp=gcloud-change-project

gcloud-compute-ssh() {
    CHOICE_LINE=`gcloud compute instances list | fzf -m`
    if [ -n "${CHOICE_LINE}" ]; then
        NAME=`echo ${CHOICE_LINE} | awk '{print $1}'`
        ZONE=`echo ${CHOICE_LINE} | awk '{print $2}'`
        gcloud compute ssh --zone ${ZONE} ${NAME}
    fi
}
alias gcssh=gcloud-compute-ssh
