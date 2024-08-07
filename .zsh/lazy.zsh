#!/usr/bin/zsh

# Install and load zsh-defer
if [ -e $HOME/zsh-defer ]; then
    source ~/zsh-defer/zsh-defer.plugin.zsh
else
    git clone https://github.com/romkatv/zsh-defer $HOME/zsh-defer
    source ~/zsh-defer/zsh-defer.plugin.zsh
fi

# Install and lazy load fast-syntax-highlighting
zsyhidir=$HOME/fast-syntax-highlighting
zsyhifile=${zsyhidir}/fast-syntax-highlighting.plugin.zsh
if [ -e ${zsyhidir} ]; then
    zsh-defer source ${zsyhifile}
else
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ${zsyhidir}
    zsh-defer source ${zsyhifile}
fi

# Install and lazy load zsh-autosuggestions
zausudir=$HOME/zsh-autosuggestions
zausufile=${zausudir}/zsh-autosuggestions.zsh
if [ -e ${zausudir} ]; then
    zsh-defer source ${zausufile}
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${zausudir}
    zsh-defer source ${zausufile}
fi

zsh-defer source ~/.zsh/command_hook.zsh
