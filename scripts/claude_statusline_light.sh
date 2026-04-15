#!/bin/bash
# https://qiita.com/dai_chi/items/d72ec42444d66e88a044

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
workspace=$(echo "$input" | jq -r '.workspace.current_dir // ""')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

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

cost_display=$(printf '$%.2f' "$cost")

echo -e "${LAVENDER}🤖Model:${model}${RESET} ${SUBTEXT0}▸${RESET} ${TEXT}📁WorkSpace:${ws_name}${RESET} ${SUBTEXT0}▸${RESET} ${TEAL}🌿Branch:${branch}${RESET}"
echo -e "${TEXT}🪣Context:${RESET} ${BAR_COLOR}${bar}${RESET} ${TEXT}${context_int}%${RESET} ${SUBTEXT0}▸${RESET} ${PEACH}💰Cost:${cost_display}${RESET}"
