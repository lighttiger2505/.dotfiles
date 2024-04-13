# vim key bind
bindkey -v

# Search history
bindkey '^P' atuin-up-search
bindkey '^N' atuin-up-search

# Vim normal mode keybind
bindkey -M vicmd 'H'  beginning-of-line
bindkey -M vicmd 'L'  end-of-line

# Vim insert mode keybind
bindkey -M viins '^A'  beginning-of-line
bindkey -M viins '^B'  backward-char
bindkey -M viins '^D'  delete-char-or-list
bindkey -M viins '^E'  end-of-line
bindkey -M viins '^F'  forward-char
bindkey -M viins '^H'  backward-delete-char

# Fuzzy finder command
bindkey '^L' cd-fzf-ghqlist
bindkey '^O' checkout-fzf-gitbranch
bindkey '^\' ssh-fzf-sshconfig

# Open editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^J' edit-command-line
