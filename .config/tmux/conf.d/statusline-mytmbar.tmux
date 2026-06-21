setw -g window-status-format "#(mytmbar window --path '#{pane_current_path}' --cmd '#{pane_current_command}' --pid '#{pane_pid}' --title '#{pane_title}' --pane-id '#{pane_id}')"
setw -g window-status-current-format "#(mytmbar window --path '#{pane_current_path}' --cmd '#{pane_current_command}' --pid '#{pane_pid}' --title '#{pane_title}' --pane-id '#{pane_id}')"
