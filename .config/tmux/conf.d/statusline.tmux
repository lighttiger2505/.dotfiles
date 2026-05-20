# Left status bar display setting
set -g status-interval 1
set -g status-left-length 128
set -g status-left " #{session_name} "

# Right status bar display setting
set -g status-right-length 128
set -g status-right " %Y/%m/%d(%a) %H:%M "

# Window display setting: mytmbar があれば優先、無ければシェルスクリプト
if-shell '[ -x "$HOME/go/bin/mytmbar" ]' \
    'source-file ~/.config/tmux/conf.d/statusline-mytmbar.tmux' \
    'source-file ~/.config/tmux/conf.d/statusline-fallback.tmux'
