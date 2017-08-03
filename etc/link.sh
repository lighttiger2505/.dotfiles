ROOT_DIR=~/.dotfiles
NVIM_CONF_DIR=~/.config/nvim

if ! [ -e $NVIM_CONF_DIR ]; then
    mkdir -p $NVIM_CONF_DIR
fi

rm ~/.vim
ln -s $ROOT_DIR/vim ~/.vim

rm ~/.vimrc
ln -s $ROOT_DIR/vim/vimrc ~/.vimrc

rm ~/.zshrc
ln -s $ROOT_DIR/.zshrc ~/.zshrc

rm ~/.zshenv
ln -s $ROOT_DIR/.zshenv ~/.zshenv

rm ~/.zshrc.linux
ln -s $ROOT_DIR/.zshrc.linux ~/.zshrc.linux

rm ~/.ctags
ln -s $ROOT_DIR/.ctags ~/.ctags

rm ~/.tmux.conf
ln -s $ROOT_DIR/tmux.conf ~/.tmux.conf

rm $NVIM_CONF_DIR/init.vim
ln -s ~/.vimrc $NVIM_CONF_DIR/init.vim

rm $NVIM_CONF_DIR/vim
ln -s ~/.vim $NVIM_CONF_DIR/vim
