# Left status bar display setting
set -g status-interval 1
set -g status-left-length 128
set -g status-left " Session #{session_name} "

# Right status bar display setting
set -g status-right-length 128
set -g status-right " %Y/%m/%d(%a) %H:%M "

# Window display setting
setw -g window-status-format \
    ' #{window_index} #(${HOME}/.config/tmux/tmux-window-status.sh #{pane_current_path} #{window_name} #{pane_pid}) #{?#{m:#W,nvim},📝 ,}'
setw -g window-status-current-format \
    ' #{window_index} #(${HOME}/.config/tmux/tmux-window-status.sh #{pane_current_path} #{window_name} #{pane_pid}) #{?#{m:#W,nvim},📝 ,}'
