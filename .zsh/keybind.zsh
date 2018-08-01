# vim key bind
bindkey -v

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Incrimental search on the fzf
bindkey '^V' fzf-vim-open-file
bindkey '^O' fzf-git-branch-checkout
bindkey '^R' fzf-cmd-history
bindkey '^G' fzf-ghq=repository
bindkey '^\' fzf-ssh-host

# Vim normal mode keybind
bindkey -M vicmd 'H'  beginning-of-line
bindkey -M vicmd 'L'  end-of-line

# Vim insert mode keybind
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^H'  backward-delete-char
