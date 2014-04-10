
# LANG
export LANG=ja_JP.UTF-8

# JAVA_HOME
if [ "$OSTYPE" = "Darwin" ]
then
    export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v 1.6`
fi

# RSENSE_HOME
export RSENSE_HOME=/opt/rsense-0.3

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
~/bin(N-/)
## Java
JAVA_HOME/bin(N-/)
## Cabal
$HOME/.cabal/bin(N-/)
## rvm(ruby version control)
$HOME/.rvm/bin(N-/)
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

# alias
## Common
alias ls="ls -GF"
alias gls="gls --color"
alias lsa="ls -al"
alias lsr="ls -ltr"

## Homebrew
alias b="brew"
alias bs="brew -S"
alias bi="brew info"
alias bl="brew list"
alias bh="brew home"
alias bopt="brew options"
alias bout="brew outdated"
alias bup="brew update"
alias bupg="brew upgrade"

## Git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gpus="git push"
alias gpul="git pull"

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

