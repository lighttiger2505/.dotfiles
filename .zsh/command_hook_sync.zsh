#!/usr/bin/zsh

if executable direnv; then
    eval "$(direnv hook zsh)"
fi

if executable wt; then
    eval "$(command wt config shell init zsh)"
fi
