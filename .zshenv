
# LANG
export LANG=ja_JP.UTF-8

# golang
export GOPATH=$HOME/go

# pyenv
export PYENV_PATH=$HOME/.pyenv

# Google Cloud Platform
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Google/GoogleCloudPlatform/OAuth/My\ First\ Project-31c76eed5740.json

# Path
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

# Editor
## vimを使う。
export EDITOR=vim
## vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

#Neovim
export XDG_CONGIG_HOME=~/.config

# ls color setting
# export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=gxfxcxdxbxegedabagacad
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# export


# alias
## Common

alias ls="ls -GF"
# alias gls="gls --color"
# alias lsa="ls -al"
# alias lsr="ls -ltr"

## Git
# alias gs="git status"
# alias ga="git add"
# alias gc="git commit"
# alias gpus="git push"
# alias gpul="git pull"

alias djrun="python manage.py runserver"
alias djshell="python manage.py shell"

# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors $LSCOLORS
