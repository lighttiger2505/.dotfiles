# LANG
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

# zplug
export ZPLUG_HOME=$HOME/.zplug
# golang
export GOPATH=$HOME/dev
# pyenv
export PYENV_PATH=$HOME/.pyenv
# Google Cloud Platform
export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Google/GoogleCloudPlatform/OAuth/My\ First\ Project-31c76eed5740.json
# Neovim
export XDG_CONGIG_HOME=~/.config
# ls cmd color
export LSCOLORS=gxfxcxdxbxegedabagacad

# defaut editor is vim
export EDITOR=nvim
alias vim=nvim
# when not exist vim then start up vi
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi
