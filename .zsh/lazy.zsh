#!/usr/bin/zsh

local ZSH_PLUGIN_HOME=$HOME/.zsh_plugins

# Function to install plugin if not exists
install_plugin() {
    local repo=$1
    local repo_tmp=${repo%/}
    repo_tmp=${repo_tmp##*/}
    repo_tmp=${repo_tmp%.git}
    local dir_name=${ZSH_PLUGIN_HOME}/${repo_tmp}

    if [ ! -e ${dir_name} ]; then
        git clone --depth 1 --recursive ${repo} ${dir_name}
    fi
}

# Function to load plugin with optional defer
load_plugin() {
    local plugin=$1
    local dir_name=${ZSH_PLUGIN_HOME}/${plugin}

    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
        local plugin_file=${dir_name}/${initscript}
        if [[ -f ${plugin_file} ]]; then
            if executable zsh-defer; then
                zsh-defer source ${plugin_file}
            else
                source ${plugin_file}
            fi
            break
        fi
    done
}

# Install and load zsh-defer
install_plugin "https://github.com/romkatv/zsh-defer"
load_plugin "zsh-defer"

# Install and load zsh plugins with zsh-defer
install_plugin "https://github.com/zdharma-continuum/fast-syntax-highlighting"
load_plugin "fast-syntax-highlighting"
install_plugin "https://github.com/zsh-users/zsh-autosuggestions"
load_plugin "zsh-autosuggestions"

# Load command hook with zsh-defer
zsh-defer source ~/.zsh/command_hook.zsh
