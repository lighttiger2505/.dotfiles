---
name: commit-push-pr
description: 現在のファイル差分をコミット・プッシュし、プルリクエストを作成する。「コミットして」「プッシュして」「PRを作って」「プルリクを出して」「変更を送って」「commit」「push」「pull request」「PR」「open a PR」「submit for review」などのフレーズが含まれる場合は必ずこのスキルを使う。gitのコミット＋PRワークフロー全般に使用すること。
---

# Git コミット → プッシュ → プルリクエスト作成スキル

このスキルは、現在の変更をコミットし、リモートにプッシュして、プルリクエストを作成するまでの一連の作業を担う。

## Step 1: 差分を確認する

まず変更の全体像を把握する：

```bash
# ステージされていない変更を確認
git diff
# すでにステージされた変更を確認
git diff --cached
# 全体のステータスを確認
git status
```

差分を読んで内容を把握すること。予期しない変更や、含めるべき未追跡ファイルがあればユーザーに確認する。

## Step 2: 変更をステージする

```bash
# すべてをステージする：
git add -A
# 特定ファイルだけをステージする（ユーザーが選択的にコミットしたい場合）：
git add path/to/file1 path/to/file2
# ステージ済みの内容を確認：
git diff --cached --stat
```

関連しそうな未追跡ファイルがあれば、含めるかどうかユーザーに確認する。

## Step 3: コミットする

```bash
git commit -m "メッセージ" -m "変更の背景や理由を詳しく書く。"
```

コミットテンプレートがあればそのコミットテンプレートに従う

## Step 4: ブランチ戦略を決める

```bash
# 現在のブランチを確認
git branch --show-current
git remote -v
```

**すでにフィーチャーブランチにいる場合** → そのままプッシュ：
```bash
git push origin HEAD
```

**main / master / develop にいる場合** → 新しいブランチを作ってからプッシュ：
```bash
git checkout -b feat/機能名
git push -u origin HEAD
```

## Step 5: プルリクエストを作成する

```bash
# `gh` CLI（GitHub CLI）を使う。まず使えるか確認
gh auth status
# 基本的なPR作成
gh pr create \
  --title "タイトル" \
  --body "変更内容" \
  --draft
  --base develop
```

- Pull Requestの内容の書き方ついては他スキル`./pr-desc.md`を参照
- Pull Requestを作るときはドラフトで作ること

## 注意点

- コミットメッセージとPR本文は**実行前にユーザーに確認**してから進めること
- プロジェクトにPRテンプレート（`.github/pull_request_template.md`）がある場合は先に読んでその形式に従う
