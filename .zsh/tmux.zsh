# Install tmux plugin manager (tpm) if not already installed
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Automatically start tmux when login to shell
if executable tmux; then
    tmux has-session -t ${TMUX_DEFAULT_SESSION} 2>/dev/null || tmux new-session -d -s ${TMUX_DEFAULT_SESSION}
fi

# Attach to tmux session if not already inside tmux and if the shell is interactive
if [[ -o interactive ]] && [[ -z "${TMUX-}" ]]; then
    tmux attach -t ${TMUX_DEFAULT_SESSION}
fi
