#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    ~/.dotfiles/etc/setup/brew.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux
    ~/.dotfiles/etc/setup/apt.sh
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi
