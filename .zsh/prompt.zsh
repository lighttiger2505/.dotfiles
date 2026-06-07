autoload -Uz colors; colors

setopt prompt_subst
setopt re_match_pcre

# Return the current git branch name, or empty string outside a repo.
function current-git-branch() {
    git rev-parse --abbrev-ref=loose HEAD 2>/dev/null
}

# Return "+A -D" with the number of added/deleted lines against HEAD,
# or empty string when the working tree is clean.
function git-diff-stats() {
    local stats added=0 deleted=0 a d
    stats=$(git diff --numstat HEAD 2>/dev/null)
    [[ -z "$stats" ]] && return 0
    while read a d _; do
        added=$((added + a))
        deleted=$((deleted + d))
    done <<< "$stats"
    echo "+${added} -${deleted}"
}

# Build a Powerline-style prompt with colored segments joined by  arrows.
#
# Segments (left to right):
#   1. cwd        – blue bg, white fg
#   2. git branch – green bg (clean) / yellow bg (dirty), black fg
#
# 2nd line: ❯ (success, green) / exit-code + ✗ (failure, red) / = (interrupt, yellow).
function zle-line-init zle-line-finish {
    local -a seg_txt seg_bg seg_fg

    # --- Segment 0: fixed mark ---
    seg_txt+=( " 🎈🐯 " )
    seg_bg+=( white )
    seg_fg+=( black )

    # --- Segment 1: current working directory ---
    seg_txt+=( "  %~ " )
    seg_bg+=( blue )
    seg_fg+=( black )

    # --- Segment 2: git branch + diff stats ---
    local br
    br=$(current-git-branch)
    if [[ -n $br ]]; then
        local diff_stats
        diff_stats=$(git-diff-stats)
        if [[ -n $diff_stats ]]; then
            seg_txt+=( $'  '"$br $diff_stats"$' ' )
            seg_bg+=( yellow )
            seg_fg+=( black )
        else
            seg_txt+=( $'  '"$br"' ' )
            seg_bg+=( green )
            seg_fg+=( black )
        fi
    fi

    # --- Assemble segments with  (U+E0B0) separator arrows ---
    local sep=$''  # Powerline right-filled arrow
    local line="" prev_bg=""
    local i
    for (( i = 1; i <= ${#seg_txt}; i++ )); do
        if [[ -n $prev_bg ]]; then
            # Arrow: fg = previous bg color, bg = current segment bg
            line+="%K{${seg_bg[i]}}%F{$prev_bg}${sep}"
        fi
        line+="%K{${seg_bg[i]}}%F{${seg_fg[i]}}${seg_txt[i]}"
        prev_bg=${seg_bg[i]}
    done
    # Trailing arrow back to terminal background
    line+="%k%F{$prev_bg}${sep}%f"

    local p_mark="%B%(130?.%F{yellow}=%f.%(?.%F{green}❯%f.%F{red}%? ✗%f))%b"
    PROMPT="${line}
${p_mark} "

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
