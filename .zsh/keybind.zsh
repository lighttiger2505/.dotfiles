# vim key bind
bindkey -v

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# # Incrimental search on the peco
# bindkey '^R' peco-cmd-history
# bindkey '^B' peco-git-branch-checkout
# bindkey '^G' peco-src
# bindkey '^\' peco-ssh-hosts

# Incrimental search on the fzf
bindkey '^V' fzf-vim-open-file
bindkey '^O' fzf-git-branch-checkout
bindkey '^R' fzf-cmd-history
bindkey '^G' fzf-ghq=repository
bindkey '^\' fzf-ssh-host

# # vim line text object
# autoload -U select-bracketed
# zle -N select-bracketed
# for m in visual viopp; do
#   for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
#     bindkey -M $m $c select-bracketed
#   done
# done
#
# autoload -U select-quoted
# zle -N select-quoted
# for m in visual viopp; do
#   for c in {a,i}{\',\",\`}; do
#     bindkey -M $m $c select-quoted
#   done
# done

# # surround like text object
# autoload -Uz surround
# zle -N delete-surround surround
# zle -N change-surround surround
# zle -N add-surround surround
# bindkey -a cs change-surround
# bindkey -a ds delete-surround
# bindkey -a ys add-surround
# bindkey -M visual S add-surround

# Vim normal mode keybind
bindkey -M vicmd 'H'  beginning-of-line
bindkey -M vicmd 'L'  end-of-line

# Vim insert mode keybind
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^H'  backward-delete-char
