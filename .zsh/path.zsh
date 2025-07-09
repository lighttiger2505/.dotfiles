#!/usr/bin/zsh

# Path/Valiables
typeset -U path
path=(
# mise
$HOME/.local/share/mise/shims
# brew
/opt/homebrew/bin(N-/)
/opt/homebrew/sbin(N-/)
# bin
/usr/local/bin(N-/)
/usr/bin(N-/)
/bin(N-/)
# sbin
/usr/local/sbin(N-/)
/usr/sbin(N-/)
/sbin(N-/)
# Go lang
$GOPATH/bin(N-/)
# npm bin
$HOME/.npm-global/bin(N-/)
# goenv
$GOENV_ROOT/bin(N-/)
# volta
$VOLTA_HOME/bin(N-/)
# mise
$HOME/.local/share/mise/shims

# GNU utils for mac
# coreutils
/usr/local/opt/coreutils/libexec/gnubin(N-/)
# ed
/usr/local/opt/ed/libexec/gnubin(N-/)
# findutils
/usr/local/opt/findutils/libexec/gnubin(N-/)
# sed
/usr/local/opt/gnu-sed/libexec/gnubin(N-/)
# tar
/usr/local/opt/gnu-tar/libexec/gnubin(N-/)
# grep
/usr/local/opt/grep/libexec/gnubin(N-/)
${path}
)

manpath=(
# coreutils
/usr/local/opt/coreutils/libexec/gnubin(N-/)
# ed
/usr/local/opt/ed/libexec/gnubin(N-/)
# findutils
/usr/local/opt/findutils/libexec/gnubin(N-/)
# sed
/usr/local/opt/gnu-sed/libexec/gnubin(N-/)
# tar
/usr/local/opt/gnu-tar/libexec/gnubin(N-/)
# grep
/usr/local/opt/grep/libexec/gnubin(N-/)
${manpath}
)
