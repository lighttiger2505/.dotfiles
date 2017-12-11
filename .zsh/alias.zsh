# ls
alias ll="ls -al"
alias lr="ls -ltr"

# git status
alias gs="git status"

# git diff
alias gd="git diff"
alias gdc="git diff --cached "

# git log
alias gl="git log"
alias glogn="git log --oneline --graph -n10"

# tig status
alias ts="tig status"

# Django manage.py
alias djrun="python manage.py runserver"
alias djshell="python manage.py shell"

# zshrc source
alias zs="source ~/.zshrc"

# zshrc load benchmark
alias zb="time ( zsh -i -c exit; )"

alias al="alacritty"

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

# Launch markdown diary
function open_diary() {
  mkdir -p ~/diary/$(date "+%Y/%m")
  vim ~/diary/$(date "+%Y/%m/%d.md")
}
alias dia=open_diary

# lab shortcut
alias lb='lab browse'
alias li='lab issue'
alias lm='lab merge-request'

# Browse selected issue
alias lbi='lab browse `lab issue | fzf -m | awk '\''{print $1}'\''`'

# Browse selected merge request
alias lbm='lab browse `lab merge-request | fzf -m | awk '\''{print $1}'\''`'

# Select git branch
alias -g B='`git branch --all | grep -v HEAD | fzf -m`'

# aws profile select
alias awsp='export AWS_DEFAULT_PROFILE=`cat ~/.aws/credentials | grep -e "\[\(.*\)\]" | sed -e "s/\[//g" | sed -e "s/\]//g" | sort | fzf`'

# aws ec2 ip list
alias awse='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | [ .InstanceId, .PublicIpAddress , .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][] ]  | @tsv " | sort -k3'

# todoist
if type todoist > /dev/null 2>&1; then
    # Cmd shutcut
    alias to='todoist'
    # Select todo key
    alias -g T='`todoist list | fzf -m | awk '\''{print $1}'\''`'
fi
