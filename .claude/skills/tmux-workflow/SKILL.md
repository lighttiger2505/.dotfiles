---
name: tmux-workflow
description: Claude Code用に新規作成したtmuxセッション上でplan → git worktree切り替え → commit-push → PR作成 の一連のワークフローを作業を実施するための手順
---

# cc-workflow: plan → worktree → PR → cleanup

このスキルはtmuxセッション内でのClaude Codeの標準ワークフローを定義する。
タスクを受け取り、ブランチ作成・実装・PR作成・セッションクリーンアップまでを一貫して担う。

## ワークフロー

### Step 1: プランニング & ブランチ名の提案

タスクを整理してプランをまとめ、ブランチ名を**1つ**提案する。

**ブランチ命名規則:**
- prefix: `feat`, `fix`, `chore`, `docs`, `refactor`
- kebab-case、英小文字
- 例: `feat-add-driver-filter`, `fix-request-timestamp-null`

ユーザーに以下を提示して確認を得る：

```
## プラン
（タスクの概要・変更方針）

## ブランチ名の提案
`feat/xxx`

このブランチ名で進めますか？（変更する場合は別名を指定してください）
```

ユーザーの承認 or 別名の指定を待ってから次のステップへ進む。

### Step 2: tmuxセッションのリネーム

ブランチ名が確定したら、現在のtmuxセッションを確定名にリネームする。

```bash
CURRENT_SESSION=$(tmux display-message -p '#S')
REPO_NAME=$(basename $(git rev-parse --show-toplevel))
tmux rename-session -t "$CURRENT_SESSION" "cc-${REPO_NAME}-${BRANCH_NAME//\//-}"
```

例: `cc-go-backend-143022` → `cc-go-backend-feat-add-driver-filter`

### Step 3: worktreeの作成

worktreeを作成してそのディレクトリに移動する。

```bash
wt switch --create <branch>
```

`wt switch` はシェル統合によりworktreeのディレクトリに自動でcdされる。
以降の作業はworktree内で行う。

### Step 4: 実装

プランに従って実装を進める。

- 変更は細かく、論理的なまとまりで行う
- 実装中の確認事項はユーザーに都度相談する

### Step 5: コミット

実装完了後、`wt step commit` でステージング＆コミットを行う。
（LLM生成のコミットメッセージが使われる）

```bash
wt step commit
```

### Step 6: pushとPR作成

```bash
git push -u origin <branch>
gh pr create --title "<タイトル>" --body "<本文>" --draft
```

PR本文には以下を含める：
- 変更の概要
- 対応するタスク・Issue番号（わかる場合）
- テスト・確認方法

### Step 7: tmuxセッションの削除確認

PR作成後、ユーザーに確認を取る：

```
PRを作成しました: <PR URL>

tmuxセッション「cc-{repo}-{branch}」を削除しますか？ [y/N]
```

- `y` の場合: `tmux kill-session -t $(tmux display-message -p '#S')` を実行
- `N` / その他: セッションをそのまま残す
