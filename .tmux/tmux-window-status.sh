#!/bin/bash

# ${1} tmux pane current path
# ${2} tmux window command

dirpath=${1}
cmd=${2}

cd ${dirpath}

spcmd=("zsh" "bash" "vim" "nvim");
if ! `echo ${spcmd[@]} | grep -q "$cmd"` ; then
    echo " ${cmd}"
    return
fi

gitdir=$(git rev-parse --abbrev-ref=loose HEAD 2> /dev/null)
if [ -n "${gitdir}" ]; then
    echo " $(basename ${dirpath})"
else
    echo " $(basename ${dirpath})"
fi


