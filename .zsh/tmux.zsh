if executable tmux; then
    local DEFAULT_SESSION="main"
    tmux has-session -t ${DEFAULT_SESSION} 2>/dev/null || tmux new-session -d -s ${DEFAULT_SESSION}
fi

if [[ -o interactive ]] && [[ -z "${TMUX-}" ]]; then
    tmux attach -t main
fi
