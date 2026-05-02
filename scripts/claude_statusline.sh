#!/bin/bash
# https://qiita.com/dai_chi/items/d72ec42444d66e88a044

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
workspace=$(echo "$input" | jq -r '.workspace.current_dir // ""')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
rate_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty' 2>/dev/null || echo "")
rate_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty' 2>/dev/null || echo "")
resets_at_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty' 2>/dev/null || echo "")
resets_at_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty' 2>/dev/null || echo "")
ctx_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty' 2>/dev/null || echo "")

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

ws_name="--"
[[ -n "$workspace" ]] && ws_name=$(basename "$workspace")
branch=$(git -C "$workspace" branch --show-current 2>/dev/null || echo "--")
branch="${branch:-"--"}"

context_int="${context_pct%.*}"
if (( context_int >= 90 )); then BAR_COLOR="$RED"
elif (( context_int >= 70 )); then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

filled=$(( context_int / 10 )); empty_count=$(( 10 - filled ))
bar=""
for (( i=0; i<filled; i++ )); do bar+="█"; done
for (( i=0; i<empty_count; i++ )); do bar+="░"; done

now=$(date +%s)

if [[ -n "$rate_5h" && "$rate_5h" != "null" ]]; then
  rate_5h_int="${rate_5h%.*}"
  if (( rate_5h_int >= 90 )); then r5c="$RED"; elif (( rate_5h_int >= 70 )); then r5c="$YELLOW"; else r5c="$TEAL"; fi
  if [[ -n "$resets_at_5h" && "$resets_at_5h" != "null" ]]; then
    remaining_5h=$(( resets_at_5h - now ))
    if (( remaining_5h > 0 )); then
      h5=$(( remaining_5h / 3600 )); m5=$(( (remaining_5h % 3600) / 60 ))
      reset_5h_display=" ${SUBTEXT0}(${h5}h${m5}m)${RESET}"
    else reset_5h_display=""; fi
  else reset_5h_display=""; fi
  rate_5h_display="${r5c}${rate_5h_int}%${RESET}${reset_5h_display}"
else rate_5h_display="${SUBTEXT0}--${RESET}"; fi

if [[ -n "$rate_7d" && "$rate_7d" != "null" ]]; then
  rate_7d_int="${rate_7d%.*}"
  if (( rate_7d_int >= 90 )); then r7c="$RED"; elif (( rate_7d_int >= 70 )); then r7c="$YELLOW"; else r7c="$SKY"; fi
  if [[ -n "$resets_at_7d" && "$resets_at_7d" != "null" ]]; then
    remaining_7d=$(( resets_at_7d - now ))
    if (( remaining_7d > 0 )); then
      d7=$(( remaining_7d / 86400 )); h7=$(( (remaining_7d % 86400) / 3600 ))
      reset_7d_display=" ${SUBTEXT0}(${d7}d${h7}h)${RESET}"
    else reset_7d_display=""; fi
  else reset_7d_display=""; fi
  rate_7d_display="${r7c}${rate_7d_int}%${RESET}${reset_7d_display}"
else rate_7d_display="${SUBTEXT0}--${RESET}"; fi

if [[ -n "$ctx_tokens" && "$ctx_tokens" != "null" ]]; then
  if (( ctx_tokens >= 1000 )); then
    ctx_k=$(echo "scale=1; $ctx_tokens / 1000" | bc)
    ctx_tokens_display=" ${SUBTEXT0}(${ctx_k}k)${RESET}"
  else ctx_tokens_display=" ${SUBTEXT0}(${ctx_tokens})${RESET}"; fi
else ctx_tokens_display=""; fi

cost_display=$(printf '$%.2f' "$cost")

echo -e "${LAVENDER}🤖Model:${model}${RESET} ${SUBTEXT0}▸${RESET} ${TEXT}📁WorkSpace:${ws_name}${RESET} ${SUBTEXT0}▸${RESET} ${TEAL}🌿Branch:${branch}${RESET}"
echo -e "${TEXT}🪣Context:${RESET} ${BAR_COLOR}${bar}${RESET} ${TEXT}${context_int}%${RESET}${ctx_tokens_display} ${SUBTEXT0}▸${RESET} 5h: ${rate_5h_display} ${SUBTEXT0}▸${RESET} 7d: ${rate_7d_display} ${SUBTEXT0}▸${RESET} ${PEACH}💰Cost:${cost_display}${RESET}"
