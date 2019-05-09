#!/usr/local/bin/zsh

# # zprof start
# zmodload zsh/zprof && zprof

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
source ~/.zsh/completion.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/keybind.zsh
source ~/.zsh/zplugin.zsh

# Init anyenv
if [ -e ~/.anyenv ]; then
    eval "$(anyenv lazyload)"
fi

# # Init pyenv
# if [ -e ~/.pyenv ]; then
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi

eval $(ssh-agent) > /dev/null
ssh-add ~/.ssh/id_rsa > /dev/null 2>&1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/lighttiger2505/google-cloud-sdk/path.zsh.inc' ]; then . '/home/lighttiger2505/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/lighttiger2505/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/lighttiger2505/google-cloud-sdk/completion.zsh.inc'; fi

# # zprof end
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
