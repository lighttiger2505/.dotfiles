set-environment -g TMUX_PLUGIN_MANAGER_PATH '~/.tmux/plugins'

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'alexwforsythe/tmux-which-key'
set -g @plugin 'Ataraxy-Labs/opensessions'
set -g @plugin 'Morantron/tmux-fingers'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
