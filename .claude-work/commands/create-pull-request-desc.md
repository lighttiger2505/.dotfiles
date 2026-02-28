---
description: テンプレートにしたがって、Pull Requestの説明文を作成します。このとき過去のPull Requestを読み取りして考慮に入れます。
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(git log:*)
  - Bash(git diff:*)
  - Bash(git status:*)
  - Bash(git show:*)
  - Bash(gh pr list:*)
  - Bash(gh pr view:*)
  - Bash(gh pr diff:*)
---

# PR Description Generator

1. `gh pr view --json number,title,body,headRefName,baseRefName` を実行し、現在のPR情報を取得。
2. `git log $(gh pr view --json baseRefName -q .baseRefName)..HEAD --oneline` を実行し、コミット一覧を取得
3. `.github/PULL_REQUEST_TEMPLATE.md` を読み込み、テンプレートの形式を確認
4. `gh pr list --author @me --state merged --limit 5 --json number` を実行して直近でマージされたPR取得し、その後 `gh pr view <number> --json body` を実行して本文を確認し、スタイルの参考にする
5. テンプレートとスタイルに従ってPRのタイトルおよび説明文を作成
6. `gh pr edit --title "<title>" --body "<description>"` を実行し、タイトルおよび説明文を更新
