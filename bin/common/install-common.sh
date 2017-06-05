#!/bin/bash

git clone https://github.com/zplug/zplug ~/.zplug
export ZPLUG_HOME="$HOME/.zplug"
source ~/.zplug/init.zsh

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
