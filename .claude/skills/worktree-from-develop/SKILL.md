---
name: worktree-from-develop
description: developブランチの最新を取り込んだ git worktree を新規作成して作業を開始するときに使う。「developから作業を始める」「worktreeを切って作業して」「develop最新でworktree作って」「作業用のworktreeを用意して」などのフレーズや、作業開始時にdevelopベースの隔離環境がほしいときに必ず使う。worktree・ワークツリー・develop・作業開始 などの語が出たら参照すること。
allowed-tools: Bash(git fetch:*) Bash(git worktree add:*) Bash(git ls-remote:*) Bash(git rev-parse:*) EnterWorktree
---

# develop ベースの worktree を作って作業開始

`origin/develop` の最新からブランチを切り、Claude Code のセッションをその worktree に切り替えるまでを行う。

## Step 1: origin/develop の存在確認

```bash
git ls-remote --exit-code --heads origin develop
```

- 存在する → Step 2 へ進む
- 存在しない（exit code 2）→ 停止してユーザーに確認する。「このリポジトリには `origin/develop` が見つかりませんでした。ベースブランチを教えてください」と伝え、指示を待つ。

## Step 2: develop を最新に fetch

```bash
git fetch origin develop
```

## Step 3: ブランチ名を決める

**REQUIRED SUB-SKILL:** `git-branch-naming` を参照し、`<type>/<description>` kebab-case でブランチ名を決める。

1. タスクの内容からブランチ名を提案し、ユーザーに確認する。
2. 既存ブランチとの衝突を確認する:
   ```bash
   git rev-parse --verify --quiet <branch>
   ```
   ヒットした場合は別名を提案する。

## Step 4: worktree を作成

**配置先は必ず `.claude/worktrees/<branch>` にすること。** この場所以外では次の Step 5 の `EnterWorktree(path=...)` が機能しない。

```bash
git worktree add .claude/worktrees/<branch> -b <branch> origin/develop
```

例（ブランチ名が `feat/add-user-auth` の場合）:
```bash
git worktree add .claude/worktrees/feat/add-user-auth -b feat/add-user-auth origin/develop
```

## Step 5: セッションを worktree へ切り替え

`EnterWorktree` ツールを使い、作成した worktree へセッションを移す:

```
EnterWorktree(path=".claude/worktrees/<branch>")
```

切り替え後、ユーザーに「`<branch>` (developベース) の worktree で作業準備が整いました」と報告して終了する。

## 注意事項

- このスキルの責務は **worktree 作成まで**。commit / push / PR 作成は `commit-push-pr` スキルに委ねる。
- メイン作業木（`master`）の HEAD は一切触らない。`git checkout develop` は行わない。
- `path` で入った worktree は `ExitWorktree(action="keep")` で元のディレクトリに戻れる。`remove` では自動削除されない（手動で `git worktree remove` が必要）。
