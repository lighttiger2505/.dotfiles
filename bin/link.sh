ROOT_DIR=~/.dotfiles
NVIM_CONF_DIR=~/.config/nvim

if ! [ -e $CONF_DIR ]; then
    mkdir -p $CONF_DIR
fi

if ! [ -e ~/.vim ]; then
    ln -s $ROOT_DIR/vim ~/.vim
fi
if ! [ -e ~/.vimrc ]; then
    ln -s $ROOT_DIR/vimrc ~/.vimrc
fi
if ! [ -e ~/.zshrc ]; then
    ln -s $ROOT_DIR/.zshrc ~/.zshrc
fi
if ! [ -e ~/.zshenv ]; then
    ln -s $ROOT_DIR/.zshenv ~/.zshenv
fi
if ! [ -e ~/.zshrc.linux ]; then
    ln -s $ROOT_DIR/.zshrc.linux ~/.zshrc.linux
fi
if ! [ -e ~/.ctags ]; then
    ln -s $ROOT_DIR/.ctags ~/.ctags
fi
if ! [ -e ~/.tmux.conf ]; then
    ln -s $ROOT_DIR/tmux.conf ~/.tmux.conf
fi

if ! [ -e $NVIM_CONF_DIR/init.vim ]; then
    ln -s ~/.vimrc $NVIM_CONF_DIR/init.vim
fi
