#!/bin/bash

./common/install-common.sh
if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    ./mac/install-brew.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux
    ./mac/install-apt.sh
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

./common/install-python.sh

