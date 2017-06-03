#!/bin/bash

curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
