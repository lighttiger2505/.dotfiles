#!/bin/bash

# ${1} tmux pane current path
# ${2} tmux window command

dirpath=${1}
cmd=${2}
pane_pid=${3}

# Claude Code detection
if [ "$cmd" = "node" ] && [ -n "$pane_pid" ]; then
    for child_pid in $(ps -A -o pid= -o ppid= -o comm= | awk -v ppid="$pane_pid" '$2 == ppid {print $1}'); do
        if ps -p "$child_pid" -o args= 2>/dev/null | grep -q "claude"; then
            echo "🤖 Claude Code"
            exit 0
        fi
    done
fi


spcmd=("zsh" "bash" "vim" "nvim" "tig");
if ! `echo ${spcmd[@]} | grep -q "$cmd"` ; then
    echo "✅ ${cmd}"
    exit 0
fi

cd ${dirpath}
echostr=""
gitdir=$(git rev-parse --show-toplevel 2> /dev/null)
if [ "0" -eq "${?}" ]; then
    git_common_dir=$(git rev-parse --git-common-dir 2> /dev/null)
    git_dir=$(git rev-parse --git-dir 2> /dev/null)
    if [ "$git_common_dir" != "$git_dir" ]; then
        repo_name=$(basename "$(cd "$git_common_dir/.." && pwd)")
        worktree_name=$(basename "${gitdir}")
        echostr="${echostr}🌿 ${repo_name} 🌲 ${worktree_name}"
    else
        echostr="${echostr}🌿 $(basename ${gitdir})"
    fi
else
    echostr="${echostr}📁 $(basename ${dirpath})"
fi

echo ${echostr}
