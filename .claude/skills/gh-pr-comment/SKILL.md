---
name: github-pr-review
description: GitHub Pull Request を gh CLI でレビューするときに使う。コード提案付きの pending review 作成、コメントのバッチ送信、適切なイベントタイプ（COMMENT/APPROVE/REQUEST_CHANGES）の選択を行う
allowed-tools: AskUserQuestion
---

# GitHub PR レビュー

## 概要

`gh api` を使って pending review にコード提案を含めながら GitHub Pull Request をレビューするワークフロー。**時間的プレッシャーがある場合でも、常に pending review を使ってコメントをバッチ送信する。**

**重要: レビューコメントを投稿する前に、必ずユーザーの明示的な承認を得ること。** 投稿内容を正確に提示し、AskUserQuestion で yes/no の確認を取ること。

## ワークフロー

**必須ステップ（スキップ禁止）:**

1. **レビューの下書き** — PR を分析してすべてのコメントを準備する
2. **投稿内容をユーザーに正確に提示** — AskUserQuestion で yes/no を確認する
3. **明示的な承認を得る** — ユーザーの確認を待つ
4. **レビューを投稿する** — 承認後のみ

### 承認パターン

レビューを投稿する前に、AskUserQuestion で以下を提示する:
- 各コメントのファイルと行番号
- コメントの正確な本文（コード提案を含む）
- イベントタイプ（APPROVE/REQUEST_CHANGES/COMMENT）
- レビュー全体のメッセージ

**例:**
```
質問: 「このレビューを投稿しますか？」
ヘッダー: 「PR レビュー」
選択肢:
  - はい、投稿する: 提示した通りにレビューを投稿する
  - いいえ、修正する: 内容を調整する
```

### 技術的なワークフロー

**1件のコメントであっても、常に pending review パターンを使うこと:**

```bash
# ステップ1: PENDING レビューを作成する（event フィールドなし）
gh api repos/:owner/:repo/pulls/<PR_NUMBER>/reviews \
  -X POST \
  -f commit_id="<COMMIT_SHA>" \
  -f 'comments[][path]=path/to/file.ts' \
  -F 'comments[][line]=<LINE_NUMBER>' \
  -f 'comments[][side]=RIGHT' \
  -f 'comments[][body]=コメント本文

```suggestion
// ここに提案するコードを書く
```

追加の説明...' \
  --jq '{id, state}'

# 戻り値: {"id": <REVIEW_ID>, "state": "PENDING"}

# ステップ2: pending レビューを送信する
gh api repos/:owner/:repo/pulls/<PR_NUMBER>/reviews/<REVIEW_ID>/events \
  -X POST \
  -f event="COMMENT" \
  -f body="レビュー全体のメッセージ（任意）"
```

## イベントタイプ

送信時に適切なイベントタイプを選択する:

| イベントタイプ | 使うタイミング | 例 |
|------------|-------------|-------------------|
| `APPROVE` | ブロッキングではない提案、マージ可能な PR | 軽微なスタイル改善、任意のリファクタリング |
| `REQUEST_CHANGES` | 修正必須のブロッキングな問題 | セキュリティ脆弱性、バグ、テスト失敗 |
| `COMMENT` | 中立的なフィードバック、質問 | 確認依頼、中立的な観察 |

## クイックリファレンス

### 前提情報の取得

```bash
# コミット SHA の取得
gh pr view <PR_NUMBER> --json commits --jq '.commits[-1].oid'

# リポジトリ情報（通常は gh が自動検出）
gh repo view --json owner,name
```

### 必須パラメータ

- `commit_id`: PR の最新コミット SHA
- `comments[][path]`: リポジトリルートからの相対パス
- `comments[][line]`: 終了行番号（数値は `-F` を使う）
- `comments[][side]`: 追加・変更された行には `RIGHT`（最も一般的）、削除された行には `LEFT`
- `comments[][body]`: コメント本文（任意で ```suggestion ブロックを含む）

### 任意パラメータ

- `comments[][start_line]`: 複数行のコード提案の場合（`-F` を使う）
- `event`: PENDING の場合は省略、または `COMMENT`/`APPROVE`/`REQUEST_CHANGES` を指定

### 構文ルール

✅ **やること:**
- `[]` を含むパラメータはシングルクォートで囲む: `'comments[][path]'`
- 文字列値には `-f` を使う
- 数値（行番号）には `-F` を使う
- コード提案には ` ```suggestion ` 識別子付きのトリプルバッククォートを使う

❌ **やらないこと:**
- `comments[][]` パラメータをダブルクォートで囲まない
- `-f` と `-F` フラグを混在させない
- コミット SHA の取得を忘れない

## コード提案のフォーマット

```bash
-f 'comments[][body]=問題を説明するコメント

```suggestion
// 指定した行を置き換える提案コード
const fixed = "like this";
```

提案後の追加コンテキストや説明。'
```

**重要**: コード提案は指定した行または行範囲全体を置き換える。提案コードが完全かつ正確であることを確認すること。

### エッジケース: ネストされたコードブロックを含む提案

マークダウンファイルやドキュメントへの変更を提案する場合、トリプルバッククォートの競合を避けるために4つのバッククォートまたはチルダを使う:

`````markdown
````suggestion
```javascript
// ネストしたバッククォートを含む提案コード
const example = "value";
```
````
`````

またはチルダを使う:

```markdown
~~~suggestion
```javascript
const example = "value";
```
~~~
```

## よくある間違い

| 間違い | 修正方法 |
|---------|-----|
| 時間的プレッシャーで即時投稿してしまう | それでも先に pending review を作る — その後すぐ送信できる |
| 「1件だけだから pending は不要」 | 常に pending を使う — 一貫したワークフロー、後からコメント追加も可能 |
| `comments[][]` をシングルクォートで囲み忘れる | 常にクォートする: `'comments[][path]'`（クォートなしは NG） |
| コミット SHA の取得を忘れる | `gh pr view <NUMBER> --json commits --jq '.commits[-1].oid'` を実行する |
| 間違ったイベントタイプを使う | セキュリティ/バグ → REQUEST_CHANGES、スタイル → APPROVE、質問 → COMMENT |

## レッドフラグ — パターン違反の兆候

以下のことを考えていたら止まること:
- 「ユーザーが急ぎと言ったから pending review をスキップしよう」
- 「1件だけだから直接投稿しよう」
- 「時間的プレッシャーがあるから即時投稿すべき」
- 「これだけ先に投稿して、残りはまとめよう」
- **「ユーザーはレビューの概要をもう承認したから承認ステップをスキップしていい」**
- **「投稿してから何を投稿したか伝えよう」**
- **「承認ステップは手間がかかる」**
- **「先にレビューを下書きして、gh は後で確認しよう」**
- **「gh はたぶんインストールされている、確認不要」**

**これらはすべて: 止まれ のサイン。先に gh を確認し、明示的な承認を得てから、pending review を使うこと。**

**なぜ pending review を使うのか?** 所要時間はほぼ同じ（API 2回 vs 1回）だが、重要なメリットがある:
- 最初のコメントを書いている間に追加の問題を見つけた場合、コメントを追加できる
- 送信前に自分のコメントをレビューできる
- 緊急度に関係なく一貫したワークフロー
- すべてのコメントを1件の通知にまとめて PR 著者に届ける

**なぜ承認ステップが必要か?** ユーザーは公開される内容を正確に確認する必要がある:
- レビューコメントは公開かつ永続的
- コード提案が誤っている可能性がある
- トーンの調整が必要な場合がある
- ユーザーがメッセージを洗練させたい場合がある

## 承認付きの完全な例

**ステップ1: 下書きして承認のために提示する**

まず PR を分析してコメントを下書きする。その後 AskUserQuestion を使う:

```
PR #123 をレビューし、3件の問題を見つけました。以下を投稿します:

**コメント1:** src/auth.ts 20行目
トークンの有効期限バリデーションがありません...
[コード提案を表示]

**コメント2:** src/auth.ts 35行目
エラーハンドリングがありません...
[コード提案を表示]

**コメント3:** tests/auth.test.ts 12行目
エラーケースのテストがありません...
[コード提案を表示]

**イベントタイプ:** REQUEST_CHANGES
**全体メッセージ:** 「マージ前に対処が必要な3件の問題があります。」

このレビューを投稿しますか？
```

**ステップ2: 承認後にレビューを投稿する**

```bash
# 複数コメント付きの pending review を作成する
gh api repos/:owner/:repo/pulls/123/reviews \
  -X POST \
  -f commit_id="abc123" \
  -f 'comments[][path]=src/auth.ts' \
  -F 'comments[][line]=20' \
  -f 'comments[][side]=RIGHT' \
  -f 'comments[][body]=1件目の問題...' \
  -f 'comments[][path]=src/auth.ts' \
  -F 'comments[][line]=35' \
  -f 'comments[][side]=RIGHT' \
  -f 'comments[][body]=2件目の問題...' \
  -f 'comments[][path]=tests/auth.test.ts' \
  -F 'comments[][line]=12' \
  -f 'comments[][side]=RIGHT' \
  -f 'comments[][body]=3件目の問題...' \
  --jq '{id, state}'

# 適切なイベントタイプで送信する
gh api repos/:owner/:repo/pulls/123/reviews/<REVIEW_ID>/events \
  -X POST \
  -f event="REQUEST_CHANGES" \
  -f body="マージ前に対処が必要な3件の問題があります。"
```

## 実際の影響

**このパターンを使わない場合:**
- 複数の別々の通知が PR 著者に届いてしまう
- フィードバックをまとめられない
- レビュー中に問題を見落としやすい
- 緊急度の感覚によって一貫性のないワークフローになる

**このパターンを使う場合:**
- すべてのフィードバックが1件のまとまったレビューになる
- PR 著者は全コンテキスト付きの1件の通知を受け取る
- 投稿前にコメントを洗練できる
- プロフェッショナルで整理されたレビューになる
