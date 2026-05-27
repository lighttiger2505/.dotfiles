---
name: failure-log
description: Claude が犯したミス・バグ・誤った設計判断を、ユーザーが指摘/修正した直後に再発防止メモとして .claude/workspace/FAILURES.md に1件追記する。ユーザーが「それは違う」「そこはこう直して」「このアプローチはやめて」など修正を入れたとき、または承認済みのPRレビュー指摘を残したいときに使う。
when_to_use: ユーザーが Claude の実装・提案の誤りを指摘・修正したとき。「直して」「やり直して」「それは間違い」「n+1になってる」「ここはusecase層」等の差し戻し発言の直後。設計に関する一般論ではなく、このセッションで実際に起きた具体的な失敗のみを記録する。
allowed-tools: Bash(mkdir *) Bash(test *) Bash(cat *) Bash(printf *) Bash(python3 *)
---

# failure-log

このセッションで起きた **具体的な失敗を1件だけ** `.claude/workspace/FAILURES.md` に追記する。
失敗を残さないと次のセッションの自分が同じミスを繰り返すため、修正が入った直後に機械的に記録する。

## 2つの入口

- **手動 / 人間観察由来**（このSkillの主用途）: ユーザーが修正を入れた・レビュー指摘が出た失敗を、下記フォーマットで追記する。`kind + tags` で記録する。
- **ハーネス由来**（3エージェントハーネスを使っている場合）: Evaluator が出す `critique.json` から自動で追記する。Evaluator skill の末尾に次の1行を仕込む（元記事の post 処理に相当）:
  ```
  python3 ${CLAUDE_SKILL_DIR}/scripts/log_from_critique.py <chunkの critique.json>
  ```
  verdict が NEEDS_REVISION / GENERATOR_FAILED のときだけ `kind + verdict + checks` 形式で追記され、APPROVED は無視される。chunk_id（例 `003_handler`）から kind を導出する。`scripts/log_from_critique.py` 冒頭の `SUFFIX_KIND` を chunk 命名に合わせて編集すること。

どちらの形式も `/failure-promote` が同じ閾値ロジックで扱う。以下は手動入口の手順。

## 記録する / しない

- 記録する: 実際に手戻りが発生した失敗（実装ミス、層の置き場所違反、n+1、エラーラップ漏れ、テスト観点漏れ、外部API/DBの仕様取り違え 等）
- 記録しない: 一般論・ベストプラクティス・「コードを2〜3ファイル読めば分かる」程度の事柄。これらはルール化してもメンテコストになるだけ。
- 1回の差し戻しにつき1ブロック。複数の失敗が混ざっていたら、最も再発しそうなもの1件に絞る。

## 追記フォーマット（厳守）

`promote.py` がパースするため、以下の形を **正確に** 守ること。`kind` と `tags` がグルーピングの鍵。

```
## <YYYY-MM-DD HH:MM UTC> — <branch> / <area>
- kind: <handler|usecase|domain|infra|migration|test|frontend|general>
- tags: <小文字・ハイフン区切りの短いキーワードを2〜4個, カンマ区切り>
- summary: <何が間違っていたか 1行>
- fix: <どう直したか 1行>
```

- `kind`: 失敗が属する層。リストにないものは `general`。
- `tags`: グルーピングの軸。**毎回同じ語彙を使う**こと（例: `n+1`, `error-wrap`, `tx-scope`, `nil-check`, `layer-leak`, `validation`）。新しい概念のときだけ新タグを作る。
- 1行 = 句点で終わる短文。複数行に分けない。

## 手順

1. branch を取得する: !`git branch --show-current 2>/dev/null || echo "no-branch"`
2. 今日時刻(UTC)を取得する: !`date -u '+%Y-%m-%d %H:%M UTC'`
3. 上記の値と、直前の失敗内容から1ブロックを組み立てる。
4. ファイルが無ければ作成し、末尾に追記する:

```bash
mkdir -p .claude/workspace
cat >> .claude/workspace/FAILURES.md <<'EOF'

## 2026-05-27 14:32 UTC — refactor-remove-unused-service-main-db / infra
- kind: infra
- tags: layer-leak, repository
- summary: DBアクセスを usecase 層に直接書いてしまい層責務が漏れた。
- fix: repository インターフェース経由に変更し infra 実装へ移した。
EOF
```

（上の中身は例。実際の値で置き換える。ヒアドキュメントは `'EOF'` でクォートし、変数展開を止める。）

5. 追記したら「FAILURES.md に1件記録した（kind/tags を一言）」とだけ短く報告する。長い説明は不要。

## 注意

- FAILURES.md は個人ローカル・gitignore対象（チーム共有しない）。整理されていない試行錯誤をそのままチームに出さないための緩衝材。
- 3件以上たまった同一パターンだけが `/failure-promote` でチームルール昇格候補になる。だからここでは閾値や昇格を気にせず、淡々と1件残すことだけに集中する。
