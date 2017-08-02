#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    ./brew.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux
    ./apt.sh
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

./setup/zplug.sh
