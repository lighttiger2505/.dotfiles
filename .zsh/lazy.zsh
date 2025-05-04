#!/usr/bin/zsh

# Function to install plugin if not exists
# Arguments:
# $1: Repository URL
# $2: Directory name
install_plugin_if_needed() {
    local repo_url=$1
    local dir_name=$HOME/$2

    if [ ! -e ${dir_name} ]; then
        git clone ${repo_url} ${dir_name}
    fi
}

# Function to load plugin with optional defer
# Arguments:
# $1: Directory name
# $2: Plugin file path (relative to directory)
# $3: Use zsh-defer (true/false)
load_plugin() {
    local dir_name=$HOME/$1
    local plugin_file=${dir_name}/$2
    local use_defer=$3

    if [[ "$use_defer" == "true" ]]; then
        zsh-defer source ${plugin_file}
    else
        source ${plugin_file}
    fi
}

# Install and load zsh-defer (without deferring itself)
install_plugin_if_needed "https://github.com/romkatv/zsh-defer" "zsh-defer"
load_plugin "zsh-defer" "zsh-defer.plugin.zsh" "false"

# Install and lazy load fast-syntax-highlighting
install_plugin_if_needed "https://github.com/zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting"
load_plugin "fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh" "true"

# Install and lazy load zsh-autosuggestions
install_plugin_if_needed "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
load_plugin "zsh-autosuggestions" "zsh-autosuggestions.zsh" "true"

# Load command hook with zsh-defer
zsh-defer source ~/.zsh/command_hook.zsh
