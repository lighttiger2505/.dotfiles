#!/usr/bin/zsh

# load settings
source $HOME/.zsh/prompt.zsh
source $HOME/.zsh/setopt.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/fzf.zsh
source $HOME/.zsh/keybind.zsh

# ssh-agent
if [ "$(pgrep ssh-agent 2> /dev/null)" = "" ]; then
    eval $(ssh-agent) > /dev/null
    case ${OSTYPE} in
        darwin*)
            ssh-add --apple-use-keychain ~/.ssh/id_rsa > /dev/null 2>&1
            ;;
        linux-gnu*)
            ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
            ;;
    esac
fi

# auto start tmux
if [[ ! -n $TMUX && $- == *l* ]]; then
    # get the IDs
    ID="`tmux list-sessions`"
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi
    create_new_session="Create New Session"
    ID="$ID\n${create_new_session}:"
    ID="`echo $ID | $PERCOL | cut -d: -f1`"
    if [[ "$ID" = "${create_new_session}" ]]; then
        tmux new-session
    elif [[ -n "$ID" ]]; then
        tmux attach-session -t "$ID"
    else
        :  # Start terminal normally
    fi
fi
