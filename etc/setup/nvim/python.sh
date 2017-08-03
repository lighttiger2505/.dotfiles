#!/bin/bash

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

pyenv install 2.7.13
pyenv install 3.5.3

pyenv virtualenv 2.7.13 neovim2
pyenv virtualenv 3.5.3 neovim3
