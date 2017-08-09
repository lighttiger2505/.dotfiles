# ls
alias ll="ls -al"

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
alias sourcez="source ~/.zshrc"

# Launch markdown diary
alias dia=open_diary

function open_diary() {
  mkdir -p ~/diary/$(date "+%Y/%m")
  vim ~/diary/$(date "+%Y/%m/%d.md")
}
