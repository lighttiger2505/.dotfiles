.dotfiles
=========
ターミナル設定、及びVimの設定

## 使用方法
ホームディレクトリにシンボリックリンクを設定
対象はつぎの通り
- .vim
- .vimrc
- .zshrc
- .zshenv
- .zshrc.osx

``` bash
ln -s ~/.vim ~/.dotfiles/.vim
ln -s ~/.vimrc ~/.dotfiles/.vim
ln -s ~/.zshrc ~/.dotfiles/.vim
ln -s ~/.zshenv ~/.dotfiles/.zshenv
ln -s ~/.zshrc.osx ~/.dotfiles/.zshrc.osx
```

## その他設定
- デフォルトのエディタをVimに変更
- デフォルトのシェルをzshに変更
- ターミナルのフォントを変更
