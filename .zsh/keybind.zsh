# vim key bind
bindkey -v

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

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
bindkey '^L' cd-git-repository
bindkey '^U' create-repository-session
bindkey '^O' switch-git-branch
bindkey '^\' cd-git-worktree

# Open editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^K' edit-command-line
