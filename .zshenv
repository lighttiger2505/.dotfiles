
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
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'
alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim'

# Pager
if type lv > /dev/null 2>&1; then
    export PAGER="lv"
else
    export PAGER="less"
fi

# lv
if [ "$PAGER" = "lv" ]; then
    export LV="-c -l"
else
    alias lv="$PAGER"
fi

# Grep
## GNU grepがあったら優先して使う。
if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi
## デフォルトオプションの設定
export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
GREP_OPTIONS="--binary-files=without-match"
### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
### 拡張子が.tmpのファイルは無視する。
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## 管理用ディレクトリを無視する。
if grep --help | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi
### 可能なら色を付ける。
if grep --help | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi

# Editor
## vimを使う。
export EDITOR=vim
## vimがなくてもvimでviを起動する。
if ! type vim > /dev/null 2>&1; then
    alias vim=vi
fi

