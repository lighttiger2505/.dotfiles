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

.github/pull_request_template.mdを参照し、このテンプレートに合わせてプルリクエウトの説明を書いてください。
過去15日間に当ユーザーが作成したpull requestを参照し、同様の文脈を持つ他のプルリクエストの内容も考慮してください。
作成済みのプルリクエストがあり、内容が特に記載されていないなら、対象のプルリクエストの説明を更新してください。
