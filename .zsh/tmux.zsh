if executable tmux; then
    local DEFAULT_SESSION="__keepalive"
    tmux has-session -t ${DEFAULT_SESSION} 2>/dev/null || tmux new-session -d -s ${DEFAULT_SESSION}
fi
