.dotfiles
=========
ターミナル設定、及びVimの設定
## 前提
homebrewインストール済み

## 必須インストール

### vim
```
brew install vim
```

### neovim
```
brew install neovim/neovim/neovim
```

### dein.vim
```
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
chmod 755 installer.sh
sh ./installer.sh ~/.vim/dein
```

### zsh
```
brew install zsh
```

## zplug
```
brew install zplug
```

## シンボリックリンク設定
ホームディレクトリにシンボリックリンクを設定
対象はつぎの通り
- .vim
- .vimrc
- .zshrc
- .zshenv
- .zshrc.osx
- .init.vim

```
ln -s ~/.dotfiles/.vim ~/.vim
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zshenv ~/.zshenv
ln -s ~/.dotfiles/.zshrc.osx ~/.zshrc.osx
ln -s ~/.vimrc ~/.config/nvim/init.vim
```
