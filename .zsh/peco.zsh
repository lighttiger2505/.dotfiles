# Select history on peco
function peco-cmd-history() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco --prompt "COMMAND HISTORYS>"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-cmd-history

# Select git repository on peco
function peco-git-branch-checkout () {
    local selected_branch_name="$(git branch -a | peco --prompt "GIT BRANCHES>" | tr -d ' ')"
    case "$selected_branch_name" in
        *-\>* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*->(.*?)\/(.*)$/\2/;print')";;
        remotes* )
            selected_branch_name="$(echo ${selected_branch_name} | perl -ne 's/^.*?remotes\/(.*?)\/(.*)$/\2/;print')";;
    esac
    if [ -n "$selected_branch_name" ]; then
        BUFFER="git checkout ${selected_branch_name}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-branch-checkout

# Search ssh hosts by prco
function peco-ssh-hosts () {
  local selected_host=$(awk '
  tolower($1)=="host" {
    for (i=2; i<=NF; i++) {
      if ($i !~ "[*?]") {
        print $i
      }
    }
  }
  ' ~/.ssh/config | sort | peco --prompt "SSH HOSTS>")
  if [ -n "$selected_host" ]; then
    BUFFER="ssh ${selected_host}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ssh-hosts

# Search ghq list
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
