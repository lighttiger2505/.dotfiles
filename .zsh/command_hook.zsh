#!/usr/bin/zsh

if executable direnv; then
    eval "$(direnv hook zsh)"
fi

if executable zoxide; then
    eval "$(zoxide init zsh --cmd cd)"
    export _ZO_FZF_OPTS='--height 70% --reverse'
fi

if executable atuin; then
    eval "$(atuin init zsh)"
fi

if [ -e $HOME/.local/bin/mise ]; then
    eval "$($HOME/.local/bin/mise activate zsh)"
fi

if executable direnv; then
    eval "$(git wt --init zsh)"
fi

# Google Cloud SDK.
# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.zsh.inc ]; then . $HOME/google-cloud-sdk/path.zsh.inc; fi
if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then . $HOME/google-cloud-sdk/completion.zsh.inc; fi
