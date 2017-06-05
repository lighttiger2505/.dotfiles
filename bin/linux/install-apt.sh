#!/bin/bash

#====================================================================
# Add repo
#====================================================================
sudo add-apt-repository ppa:neovim-ppa/stable

#====================================================================
# Update
#====================================================================
sudo apt-get update -y
sudo apt-get upgrade -y

#====================================================================
# Install
#====================================================================
# zsh
sudo apt-get install -y zsh

# commands
sudo apt-get install -y curl

# utils
sudo apt-get install -y language-pack-ja

# neovim
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties
sudo apt-get install -y neovim

# silversearcher
sudo apt-get install -y silversearcher-ag
