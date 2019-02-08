# Instaling zplugin
if [ ! -e $HOME/.zplugin ]; then
    git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

# Initialize
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Load zsh plugins
zplugin light zsh-users/zsh-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light b4b4r07/enhancd
zplugin light jocelynmallon/zshmarks

# Lazy load zsh plugins
zplugin ice wait'!1'; zplugin light greymd/tmux-xpanes
zplugin ice wait'!1'; zplugin light mollifier/cd-gitroot
zplugin ice wait'!1'; zplugin light b4b4r07/zsh-vimode-visual
zplugin ice wait'!1'; zplugin light hchbaw/opp.zsh

# Load completions
zplugin ice blockf; zplugin light zsh-users/zsh-completions
zplugin ice blockf; zplugin light felixr/docker-zsh-completion

# Load commands
zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin
zplugin ice from"gh-r" as"program"; zplugin load motemen/ghq
