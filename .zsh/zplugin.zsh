# Instaling zinit
if [ ! -e $HOME/.zinit ]; then
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

# Initialize
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zinit]=_zplugin

# Load zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light b4b4r07/enhancd
zinit light jocelynmallon/zshmarks

# Lazy load zsh plugins
zinit ice wait'!1'; zinit light b4b4r07/zsh-vimode-visual

# Load completions
zinit ice blockf; zinit light zsh-users/zsh-completions
zinit ice blockf; zinit light felixr/docker-zsh-completion
