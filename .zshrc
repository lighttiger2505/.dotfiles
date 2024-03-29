#!/usr/bin/zsh

# zprof start
if [ "$ZSHRC_PROFILE" != "" ]; then
  zmodload zsh/zprof && zprof > /dev/null
fi

# OS Type
case ${OSTYPE} in
    darwin*)
        [[ -f ~/.zshrc.osx ]] && source ~/.dotfiles/.zshrc.osx
        ;;
    linux-gnu*)
        [[ -f ~/.zshrc.linux ]] && source ~/.dotfiles/.zshrc.linux
        ;;
esac

# load settings
source ~/.zsh/path.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/keybind.zsh

if [ -e ~/.zsh/workalias.zsh ]; then
    source ~/.zsh/workalias.zsh
fi

# load plugins
if [ -e ~/.zsh-plugins/zsh-autosuggestions ]; then
    source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh-plugins/zsh-autosuggestions
fi

if [ -e ~/.zsh-plugins/fast-syntax-highlighting ]; then
    source ~/.zsh-plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
else
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh-plugins/fast-syntax-highlighting
fi

if executable direnv; then
    eval "$(direnv hook zsh)"
fi

if executable zoxide; then
    eval "$(zoxide init zsh)"
fi

 if [ -e $HOME/.asdf ]; then
    . $HOME/.asdf/asdf.sh
 fi

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi

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
