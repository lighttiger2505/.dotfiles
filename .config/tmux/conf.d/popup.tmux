# Keybind launch claude in popup
bind-key a run-shell '\
  SESSION="claude-$(echo #{pane_current_path} | md5sum | cut -c1-8)"; \
  tmux has-session -t "$SESSION" 2>/dev/null || \
  tmux new-session -d -s "$SESSION" -c "#{pane_current_path}" "zsh -ic claude; tmux detach-client"; \
  tmux display-popup -w90% -h90% -E "tmux attach-session -d -t $SESSION"'

