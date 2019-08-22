# couplete in cousor position
setopt complete_in_word
# no blob expand when complete
setopt glob_complete
# expand history when complete
setopt hist_expand
# beep sound off
setopt no_beep
# complete sort numeric
setopt numeric_glob_sort
# Auto change direcotry when directory name only in input command
setopt auto_cd
# Saving cd history
setopt auto_pushd
# Teach error of command
setopt correct
# Compact list of complate result
setopt list_packed
# Beep sound off
setopt nolistbeep
# Share history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
# setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_no_store
# Disable Ctrl-D logout
setopt IGNOREEOF
