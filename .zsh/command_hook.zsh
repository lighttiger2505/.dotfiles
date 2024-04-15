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

if [ -e $HOME/.asdf ]; then
    . $HOME/.asdf/asdf.sh
fi
