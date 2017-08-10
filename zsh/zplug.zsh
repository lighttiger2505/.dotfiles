if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# zplug settings
source $HOME/.zplug/init.zsh

# set install plugins
zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2

zplug "b4b4r07/enhancd", \
    use:init.sh

zplug "zsh-users/zsh-completions"

zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf"

zplug "junegunn/fzf", \
    as:command, \
    use:"bin/fzf-tmux"

zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    rename-to:jq

zplug "monochromegane/the_platinum_searcher", \
    as:command, \
    from:gh-r, \
    rename-to:"pt", \
    frozen:1

zplug "motemen/ghq", \
    as:command, \
    from:gh-r, \
    rename-to:ghq

# set enhancd filters
ENHANCD_FILTER=fzf:peco
export ENHANCD_FILTER

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# load zsh plugins
zplug load

if (which zprof > /dev/null) ;then
  zprof | less
fi
