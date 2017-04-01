#!/bin/zsh

#####################################################################
# init
#####################################################################

# load zshrc for os type
case ${OSTYPE} in
    darwin*)
        [[ -f ~/.zshrc.osx ]] && source ~/.zshrc.osx
        ;;
    linux-gnu*)
        [[ -f ~/.zshrc.linux ]] && source ~/.zshrc.linux
        ;;
esac

# source env
source ~/.zshenv > /dev/null

#####################################################################
# auto complete
#####################################################################

# load command completion function
autoload -Uz compinit
# load compinit
compinit

# 補完方法毎にグループ化する。
# 補完方法の表示方法
#   %B...%b: 「...」を太字にする。
#   %d: 補完方法のラベル
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

# 補完侯補をメニューから選択する。
# select=2: 補完候補を一覧から選択する。
#           ただし、補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2

# 補完候補に色を付ける。
# "": 空文字列はデフォルト値を使うという意味。
zstyle ':completion:*:default' list-colors ""

# 補完候補がなければより曖昧に候補を探す。
# m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
# r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

# 補完方法の設定。指定した順番に実行する。
# _oldlist 前回の補完結果を再利用する。
# _complete: 補完する。
# _match: globを展開しないで候補の一覧から補完する。
# _history: ヒストリのコマンドも補完候補とする。
# _ignored: 補完候補にださないと指定したものも補完候補とする。
# _approximate: 似ている補完候補も補完候補とする。
# _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer \
    _oldlist _complete _match _history _ignored _approximate _prefix
# 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
# 詳細な情報を使う。
zstyle ':completion:*' verbose yes
# sudo時にはsudo用のパスも使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# カーソル位置で補完する。
setopt complete_in_word
# globを展開しないで候補の一覧から補完する。
setopt glob_complete
# 補完時にヒストリを自動的に展開する。
setopt hist_expand
# 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
# 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort
# Auto change direcotry
setopt auto_cd
# Saving cd history
setopt auto_pushd
# Teach error of command
setopt correct
# Compact list of complate result
setopt list_packed
# Beep sound off
setopt nolistbeep

#####################################################################
# prompt
#####################################################################

# 実行中のコマンドとユーザ名とホスト名とカレントディレクトリを表示。
update_title() {
    local command_line=
    typeset -a command_line
    command_line=${(z)2}
    local command=
    if [ ${(t)command_line} = "array-local" ]; then
        command="$command_line[1]"
    else
        command="$2"
    fi
    print -n -P "\e]2;"
    echo -n "(${command})"
    print -n -P " %n@%m:%~\a"
}
# X環境上でだけウィンドウタイトルを変える。
if [ -n "$DISPLAY" ]; then
    preexec_functions=($preexec_functions update_title)
fi

# localhost info
local p_rhst=""
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    local rhost=`who am i|sed 's/ .*(\(.*\)).*/\1/'`
    rhost=${rhost#localhost:}
    rhost=${rhost%%.*}
    p_rhst="%B%F{yellow}($rhost)%f%b"
fi

# current directory
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'

# macine and user info
local p_info="%n@%m${WINDOW:+"[$WINDOW]"}"

# command result mark
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"


# show git status
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

setopt prompt_subst
setopt re_match_pcre

function rprompt-git-current-branch {

# local name st color

if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
fi

name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
if [[ -z $name ]]; then
    return
fi

st=`git status 2> /dev/null`
if [[ "$st" =~ "(?m)^nothing to" ]]; then
    color=%F{green}
elif [[ "$st" =~ "(?m)^nothing added" ]]; then
    color=%F{yellow}
elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
    color=%B%F{red}
else
    color=%F{red}
fi

echo "$color($name)%f%b "
}

local p_git='`rprompt-git-current-branch`'
local p_dir="%F{yellow}(%~)%f"

local cp_dir=" $p_dir$p_git"$'\n'
local cp_user=" %F{yellow}[$p_rhst$p_info]%f $p_mark "

PROMPT=$cp_dir$cp_user

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH=$HOME/.nodebrew/current/bin:$PATH

#####################################################################
# keybind
#####################################################################

## vi bind
bindkey -v


#####################################################################
# history
#####################################################################

## Limit of history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Share history
setopt hist_ignore_dups
setopt share_history

# Search history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#####################################################################
# plugin manager
#####################################################################

# zplug settings
source $HOME/.zplug/init.zsh

# set install plugins
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-completions"
zplug "peco/peco", \
    as:command, \
    from:gh-r, \
    frozen:1
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:"fzf", \
    frozen:1

# set enhancd filters
ENHANCD_FILTER=fzf:peco
export ENHANCD_FILTER

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# load zsh plugins
zplug load --verbose
