#!/usr/bin/zsh

if executable direnv; then
    eval "$(direnv hook zsh)"
fi

if executable wt; then
    eval "$(command wt config shell init zsh)"
fi

if [[ -r "$HOME/.local/share/deja/init.zsh" ]];
    then source "$HOME/.local/share/deja/init.zsh";
else
    eval "$(deja init zsh)";
fi

if executable zsh-patina; then
    eval "$(zsh-patina activate)"
fi
