#!/bin/bash

#====================================================================
# neovim pyenv-virtualenv
#====================================================================
pyenv install 2.7.13
pyenv install 3.5.3

pyenv virtualenv 2.7.13 neovim2
pyenv virtualenv 3.5.3 neovim3

pyenv activate neovim2
pyenv activate neovim3
