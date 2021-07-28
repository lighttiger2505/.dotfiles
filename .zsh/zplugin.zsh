# Instaling zinit
if [ ! -e $HOME/.zinit ]; then
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

# Initialize
source $HOME/.zinit/bin/zinit.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zinit]=_zplugin

# Load zsh plugins
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# Load completions
zinit ice blockf; zinit light zsh-users/zsh-completions
zinit ice blockf; zinit light felixr/docker-zsh-completion
