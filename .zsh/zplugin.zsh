source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin load zsh-users/zsh-autosuggestions
zplugin load zsh-users/zsh-syntax-highlighting
zplugin load zsh-users/zsh-completions
zplugin load b4b4r07/enhancd
zplugin load greymd/tmux-xpanes
zplugin light b4b4r07/zsh-vimode-visual
zplugin light hchbaw/opp.zsh
zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin
