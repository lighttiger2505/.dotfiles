setw -g window-status-format \
    ' #{window_index} #(${HOME}/.config/tmux/tmux-window-status.sh #{pane_current_path} #{window_name} #{pane_pid}) #{?#{m:#W,nvim},📝 ,}'
setw -g window-status-current-format \
    ' #{window_index} #(${HOME}/.config/tmux/tmux-window-status.sh #{pane_current_path} #{window_name} #{pane_pid}) #{?#{m:#W,nvim},📝 ,}'
