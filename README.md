.dotfiles
=========
lighttiger's cli

# Installation
```bash
$ cd ~/.dotfiles
$ make init
```

# Install requirement
- vim
- neovim
- zsh
- zplug
- pyenv
- pyenv-vertualenv
- tmux
- the silver searcher(ga) or The Platinum Searcher(pt)

# Install python

```bash
# Install python version
pyenv install 2.7.12 # latest version
pyenv install 3.4.5 # latest version

# Create pyenv-vertualevn for neovim reference
pyenv virtualenv 2.7.12 neovim2
pyenv virtualenv 3.4.5 neovim3

# Install neovim client and requirement middle 
pyenv activate neovim2
pip install -r ~/.dotfiles/python/neovim2_requirements.txt
pyenv which python  # Note the path
pyenv deactivate

pyenv activate neovim3
pip install -r ~/.dotfiles/python/neovim3_requirements.txt
pyenv which python  # Note the path
pyenv deactivate
```

# Synbolic link

- .vim
- .vimrc
- .zshrc
- .zshenv
- .zshrc.osx
- .init.vim
- .tmux.conf

```bash
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zshenv ~/.zshenv
ln -s ~/.dotfiles/.zshrc.osx ~/.zshrc.osx
ln -s ~/.vimrc ~/.config/nvim/init.vim
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
```
