# Enter copy mode
set -s set-clipboard on

# Use vim keybindings in copy mode
setw -g mode-keys vi

# Keybind copy mode
bind-key -n M-[ copy-mode -e
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi V send-keys -X select-line
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy && wl-paste -n | wl-copy -p"
