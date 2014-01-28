
# LANG
export LANG=ja_JP.UTF-8

# Color support
if [ "$TERM" = "xterm" ]
then
    export TERM="xterm-256color"
fi

# Path
typeset -U path
path=(
## System
/bin(N-/)
/usr/local/bin(N-/)
/usr/bin(N-/)
/usr/games(N-/)
## Cabal
$HOME/.cabal/bin(N-/)
)

# Sudo path
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# alias setting
## MacVim
if [[ `uname` = "Darwin" ]]; then
    if [[ -d /Applications/MacVim.app ]]; then
        alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
        alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/MacVim'
    fi
fi

# Editor
## vimを使う。
export EDITOR=vim
## vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

# ls color setting
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -GF"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

