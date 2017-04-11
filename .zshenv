
# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

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
# bin
/usr/local/bin(N-/)
/usr/bin(N-/)
/bin(N-/)
# sbin
/usr/local/sbin(N-/)
/usr/sbin(N-/)
/sbin(N-/)
# Java
$JAVA_HOME/bin(N-/)
# Cabal
$HOME/.cabal/bin(N-/)
# rvm(ruby version control)
$HOME/.rvm/bin(N-/)
# Go lang
$GOPATH/bin(N-/)
# pyenv
$PYENV_PATH/bin(N-/)
$PYENV_PATH/shims(N-/)
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

# ls
alias ll="ls -al"

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

# autoenv
function write_autoenv() {
    echo 'source venv/bin/activate' > .autoenv.zsh
    echo 'deactivate' > .autoenv_leave.zsh
}
alias autoenv=write_autoenv

# cd-gitroot
alias cdr="cd-gitroot"

# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors $LSCOLORS

#####################################################################
# Init pyenv
#####################################################################

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

