# vim key bind
bindkey -v

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Incrimental search on the peco
bindkey '^R' peco-cmd-history
bindkey '^B' peco-git-branch-checkout
bindkey '^G' peco-src
bindkey '^\' peco-ssh-hosts
