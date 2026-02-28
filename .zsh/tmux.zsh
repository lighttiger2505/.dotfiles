if executable tmux; then
    tmux has-session -t ${TMUX_DEFAULT_SESSION} 2>/dev/null || tmux new-session -d -s ${TMUX_DEFAULT_SESSION}
fi

if [[ -o interactive ]] && [[ -z "${TMUX-}" ]]; then
    tmux attach -t ${TMUX_DEFAULT_SESSION}
fi
