#!/bin/bash
# Claude Code完了通知スクリプト
# terminal-notifier使用（ノンブロッキング）
# 通知タップ時に該当tmuxペインをアクティブにする
#
# Usage: notify-complete.sh [stop|notification]

EVENT_TYPE="${1:-stop}"

# stdinからhookデータを読み取り
STDIN_DATA=$(cat)

# transcript_pathから最後のユーザープロンプトを抽出
LAST_PROMPT=""
TRANSCRIPT_PATH=$(echo "$STDIN_DATA" | \
    python3 -c "import sys,json; \
    print(json.load(sys.stdin).get('transcript_path',''))" \
    2>/dev/null)

if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
    LAST_PROMPT=$(python3 -c "
import json, sys
last = ''
with open('$TRANSCRIPT_PATH') as f:
    for line in f:
        data = json.loads(line)
        if data.get('type') == 'user':
            msg = data.get('message', {})
            if isinstance(msg, dict):
                content = msg.get('content', '')
                if isinstance(content, list):
                    for c in content:
                        if isinstance(c, dict) and c.get('type') == 'text':
                            text = c['text'].strip()
                            if text and not text.startswith('<'):
                                last = text
                elif isinstance(content, str) and not content.startswith('<'):
                    last = content.strip()
# 60文字で切り詰め
if len(last) > 60:
    last = last[:57] + '...'
print(last)
" 2>/dev/null)
fi

# イベント種別で音とメッセージを分ける
if [ "$EVENT_TYPE" = "notification" ]; then
    SOUND="Glass"
    MESSAGE="入力待ち"
else
    SOUND="Hero"
    MESSAGE="完了"
fi

# 最後のプロンプトがあれば通知メッセージに使う
NOTIFY_MESSAGE="${LAST_PROMPT:-${MESSAGE}}"

# TMUX_PANEから現在のペイン情報を取得
if [ -n "$TMUX_PANE" ]; then
    TMUX_SESSION=$(tmux display-message -t "$TMUX_PANE" \
        -p '#{session_name}' 2>/dev/null)
    TMUX_WINDOW=$(tmux display-message -t "$TMUX_PANE" \
        -p '#{window_index}' 2>/dev/null)
    TMUX_WINDOW_NAME=$(tmux display-message -t "$TMUX_PANE" \
        -p '#{window_name}' 2>/dev/null)
    TMUX_PANE_INDEX=$(tmux display-message -t "$TMUX_PANE" \
        -p '#{pane_index}' 2>/dev/null)
else
    TMUX_SESSION=$(tmux display-message \
        -p '#{session_name}' 2>/dev/null)
    TMUX_WINDOW=$(tmux display-message \
        -p '#{window_index}' 2>/dev/null)
    TMUX_WINDOW_NAME=$(tmux display-message \
        -p '#{window_name}' 2>/dev/null)
    TMUX_PANE_INDEX=$(tmux display-message \
        -p '#{pane_index}' 2>/dev/null)
fi

# tmux外で実行された場合はフォールバック
if [ -z "$TMUX_SESSION" ] || [ -z "$TMUX_WINDOW" ]; then
    osascript -e "display notification \"${NOTIFY_MESSAGE}\" \
        with title \"Claude Code\"" &
    afplay "/System/Library/Sounds/${SOUND}.aiff" &
    exit 0
fi

# -execute は /bin/sh で実行されるためフルパスが必要
TMUX_BIN="/opt/homebrew/bin/tmux"
OSASCRIPT_BIN="/usr/bin/osascript"

# クリック時のコマンド:
# ターミナルをアクティブ → tmuxウィンドウ選択 → ペイン選択
CLICK_CMD="${OSASCRIPT_BIN} -e \
    'tell application \"Ghostty\" to activate'; \
    sleep 0.3; \
    ${TMUX_BIN} select-window \
        -t '${TMUX_SESSION}:${TMUX_WINDOW}'; \
    ${TMUX_BIN} select-pane \
        -t '${TMUX_SESSION}:${TMUX_WINDOW}.${TMUX_PANE_INDEX}'"

# terminal-notifierで通知（ノンブロッキング）
terminal-notifier \
    -title "Claude Code" \
    -subtitle "${MESSAGE}" \
    -message "${NOTIFY_MESSAGE}" \
    -sound "${SOUND}" \
    -execute "${CLICK_CMD}" \
    -group "claude-code-${TMUX_SESSION}-${TMUX_WINDOW}" &
