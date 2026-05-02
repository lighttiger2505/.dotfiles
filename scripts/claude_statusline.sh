#!/bin/bash
# https://qiita.com/dai_chi/items/d72ec42444d66e88a044

input=$(cat)

IFS=$'\t' read -r model context_pct workspace cost rate_5h rate_7d resets_at_5h resets_at_7d ctx_tokens \
  <<< "$(echo "$input" | jq -r '[
    (.model.display_name // "Unknown"),
    (.context_window.used_percentage // 0),
    (.workspace.current_dir // ""),
    (.cost.total_cost_usd // 0),
    (.rate_limits.five_hour.used_percentage // ""),
    (.rate_limits.seven_day.used_percentage // ""),
    (.rate_limits.five_hour.resets_at // ""),
    (.rate_limits.seven_day.resets_at // ""),
    (.context_window.current_usage.input_tokens // "")
  ] | @tsv' 2>/dev/null)"

# Catppuccin Mocha palette (truecolor)
LAVENDER="\033[38;2;180;190;254m"
SUBTEXT0="\033[38;2;166;173;200m"
GREEN="\033[38;2;166;227;161m"
YELLOW="\033[38;2;249;226;175m"
RED="\033[38;2;243;139;168m"
PEACH="\033[38;2;250;179;135m"
TEAL="\033[38;2;148;226;213m"
SKY="\033[38;2;137;220;235m"
TEXT="\033[38;2;205;214;244m"
RESET="\033[0m"

threshold_color() {
  if (( $1 >= 90 )); then printf -v "$2" '%s' "$RED"
  elif (( $1 >= 70 )); then printf -v "$2" '%s' "$YELLOW"
  else printf -v "$2" '%s' "$3"; fi
}

_result=""
format_rate() {
  local pct="$1" resets_at="$2" default_color="$3" div1="$4" unit1="$5" div2="$6" unit2="$7"
  if [[ -z "$pct" || "$pct" == "null" ]]; then
    _result="${SUBTEXT0}--${RESET}"
    return
  fi
  local pct_int="${pct%.*}" color
  threshold_color "$pct_int" color "$default_color"
  local reset_display=""
  if [[ -n "$resets_at" && "$resets_at" != "null" ]]; then
    local remaining=$(( resets_at - now ))
    if (( remaining > 0 )); then
      local u1=$(( remaining / div1 )) u2=$(( (remaining % div1) / div2 ))
      reset_display=" ${SUBTEXT0}(${u1}${unit1}${u2}${unit2})${RESET}"
    fi
  fi
  _result="${color}${pct_int}%${RESET}${reset_display}"
}

ws_name="--"
[[ -n "$workspace" ]] && ws_name=$(basename "$workspace")
branch=$(git -C "$workspace" branch --show-current 2>/dev/null || echo "--")
branch="${branch:-"--"}"

context_int="${context_pct%.*}"
threshold_color "$context_int" BAR_COLOR "$GREEN"

filled=$(( context_int / 10 )); empty_count=$(( 10 - filled ))
bar=""
for (( i=0; i<filled; i++ )); do bar+="█"; done
for (( i=0; i<empty_count; i++ )); do bar+="░"; done

[[ -n "$rate_5h$rate_7d" ]] && now=$(date +%s)

format_rate "$rate_5h" "$resets_at_5h" "$TEAL" 3600 h 60 m
rate_5h_display="$_result"
format_rate "$rate_7d" "$resets_at_7d" "$SKY" 86400 d 3600 h
rate_7d_display="$_result"

ctx_tokens_display=""
if [[ -n "$ctx_tokens" && "$ctx_tokens" != "null" ]]; then
  if (( ctx_tokens >= 1000 )); then
    ctx_tokens_display=" ${SUBTEXT0}($(( ctx_tokens / 1000 )).$(( (ctx_tokens % 1000) / 100 ))k)${RESET}"
  else
    ctx_tokens_display=" ${SUBTEXT0}(${ctx_tokens})${RESET}"
  fi
fi

cost_display=$(printf '$%.2f' "$cost")

echo -e "${LAVENDER}🤖Model:${model}${RESET} ${SUBTEXT0}▸${RESET} ${TEXT}📁WorkSpace:${ws_name}${RESET} ${SUBTEXT0}▸${RESET} ${TEAL}🌿Branch:${branch}${RESET}"
echo -e "${TEXT}🪣Context:${RESET} ${BAR_COLOR}${bar}${RESET} ${TEXT}${context_int}%${RESET}${ctx_tokens_display} ${SUBTEXT0}▸${RESET} 5h: ${rate_5h_display} ${SUBTEXT0}▸${RESET} 7d: ${rate_7d_display} ${SUBTEXT0}▸${RESET} ${PEACH}💰Cost:${cost_display}${RESET}"
