# zmodload zsh/zprof && zprof

# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8


#####################################################################
# export
#####################################################################

# zplug
export ZPLUG_HOME=$HOME/.zplug
# golang
export GOPATH=$HOME/go
# pyenv
export PYENV_PATH=$HOME/.pyenv
# Google Cloud Platform
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Google/GoogleCloudPlatform/OAuth/My\ First\ Project-31c76eed5740.json
# Neovim
export XDG_CONGIG_HOME=~/.config
# ls cmd color
export LSCOLORS=gxfxcxdxbxegedabagacad


#####################################################################
# editor
#####################################################################

# defaut editor is vim
export EDITOR=vim
# when not exist vim then start up vi
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi


#####################################################################
# alias
#####################################################################

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

# neovim
alias vim=nvim

# zshrc source
alias sourcez="source ~/.zshrc"

# zshenv source
alias sourcee="source ~/.zshrc"

#####################################################################
# ls color
#####################################################################

# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors $LSCOLORS

