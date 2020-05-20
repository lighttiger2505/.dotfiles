#!/bin/bash

# ${1} tmux pane current path
# ${2} tmux window command

dirpath=${1}
cmd=${2}

cd ${dirpath}
echostr=""
gitdir=$(git rev-parse --show-toplevel 2> /dev/null)
if [ "0" -eq "${?}" ]; then
    echostr="${echostr} $(basename ${gitdir})"
else
    echostr="${echostr} $(basename ${dirpath})"
fi

echo ${echostr}
