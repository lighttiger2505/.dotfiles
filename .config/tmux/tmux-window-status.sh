#!/bin/bash

# ${1} tmux pane current path
# ${2} tmux window command
# ${3} tmux pane pid

dirpath=${1}
cmd=${2}
pane_pid=${3}

if pgrep -P "${pane_pid}" -x claude > /dev/null 2>&1; then
    echo "🤖 Claude"
    exit 0
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
