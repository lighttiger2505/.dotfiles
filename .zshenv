
# LANG
export LANG=ja_JP.UTF-8

#####################################################################
# export
#####################################################################

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
# path
#####################################################################

typeset -U path
path=(
## pyenv
$PYENV_PATH/shims(N-/)
## System
/usr/local/bin(N-/)
/bin(N-/)
/usr/bin(N-/)
/usr/games(N-/)
~/bin(N-/)
## Java
JAVA_HOME/bin(N-/)
## Cabal
$HOME/.cabal/bin(N-/)
## rvm(ruby version control)
$HOME/.rvm/bin(N-/)
## go lang
$GOPATH/bin(N-/)
## Python
/usr/sbin(N-/)
)

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

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

alias ls="ls -GF"
# alias gls="gls --color"
# alias lsa="ls -al"
# alias lsr="ls -ltr"

# git status
alias gs="git status"

# git diff
alias gd="git diff"
alias gdc="git diff --cached "

# git add
alias ga="git add "
alias gap="git add -p "

# git commit
alias gc="git commit"
alias gcm="git commit -m"

# git log
alias gl="git log"
alias glogn="git log --oneline --graph -n10"

# Django manage.py
alias djrun="python manage.py runserver"
alias djshell="python manage.py shell"

# neovim
alias vim=nvim

# zsh
alias sourcez="source ~/.zshrc"

# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors $LSCOLORS
