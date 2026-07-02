---
name: loop-code-review
description: 自分がauthorのオープンPRのうち、code-reviewが未実施のもの・レビュー後に変更されたものを列挙し、すべてをレビューする。「自分のPRをまとめてレビュー」「未レビューのPRをレビュー」「レビュー後に変更したPRを再レビュー」「自分のPRのレビュー状況を確認」などと依頼されたときに使う。
allowed-tools: Read, Grep, Glob, Bash, LSP, Workflow
context: fork
---

# 自分のPRをまとめてレビューするスキル

自分がauthorのオープンPR（Draft含む）と他人が作成した非DraftのオープンPRを列挙し、`/code-review` 未実施・レビュー後に変更があったPRをすべてレビューします。
レビューは Dynamic Workflow を使って全PRを並列実行します。

## 実行手順

### 1. リポジトリ・認証情報を取得

```bash
# リポジトリ情報
gh repo view --json owner,name --jq '"owner=\(.owner.login) repo=\(.name)"'

# 認証ユーザーのlogin名
gh api user --jq .login
```

`owner`、`repo`、`me`（自分のlogin）を後続ステップで使う。

### 2. 自分がauthorのオープンPRを列挙

```bash
gh pr list --state open \
  --json number,title,headRefName,url,isDraft,author \
  --jq '.[] | select(.author.login=="<me>" or .isDraft==false) | "\(.number)\t\(.title)\t\(.author.login)\t\(.url)"'
```

対象条件:
- 自分（`<me>`）がauthorのPR: Draft／非Draft どちらも含む
- 他人がauthorのPR: Draft でないもののみ（Bot作成のPRも含む）

PRが0件の場合は「対象PRなし」と報告して終了する。

### 3. 各PRのレビュー状態を判定

各PRについて以下を実行し、3区分に分類する。

#### 3-1. PRの最新コミットSHAを取得

```bash
gh pr view <PR番号> --json commits --jq '.commits[-1].oid'
```

#### 3-2. 自分のコメントからレビュー済みマーカーを探す

```bash
gh api repos/<owner>/<repo>/issues/<PR番号>/comments \
  --jq '.[] | select(.user.login=="<me>") | .body' \
  | grep -o 'claude-code-review reviewed-commit=[0-9a-f]*'
```

- `reviewed-commit=<SHA>` 形式のマーカーが見つかった場合、その `<SHA>` を「レビュー済みSHA」として抽出する。
- マーカーが複数あれば最後に出現したものを使う。

#### 3-3. 区分判定

| 条件 | 区分 |
|---|---|
| マーカーなし | **未レビュー** |
| マーカーあり & レビュー済みSHA == 最新コミットSHA | **レビュー済み**（スキップ） |
| マーカーあり & レビュー済みSHA != 最新コミットSHA | **レビュー後変更あり** |

### 4. 分類結果を表示

以下の3区分でPR一覧を日本語で出力する:

```
## レビュー状況

### 未レビュー（N件）
| PR | タイトル | Author | URL |
|---|---|---|---|
| #XXXX | ... | login | ... |

### レビュー後変更あり（N件）
| PR | タイトル | Author | URL |
|---|---|---|---|
| #XXXX | ... | login | ... |

### レビュー済み・スキップ（N件）
| PR | タイトル | Author | URL |
|---|---|---|---|
| #XXXX | ... | login | ... |
```

> **注意**: 本スキルの導入以前にレビューした旧PRはマーカーが存在しないため「未レビュー」に分類されます。

### 5. 対象PRを全件並列レビュー

対象PRが0件（全件スキップ）の場合は「すべてのPRはレビュー済みです」と報告して終了する。

「未レビュー」と「レビュー後変更あり」のPR全件について、Dynamic Workflow で並列実行する。
以下のスクリプトを `Workflow` ツールの `script` パラメータに渡す。
`args` には対象PR全件の情報を配列で渡す（例: `[{number: 123, title: "...", url: "...", latestSha: "abc123", reason: "未レビュー"}, ...]`）。

```javascript
export const meta = {
  name: 'review-prs-parallel',
  description: '複数PRをcode-reviewスキルで並列レビュー',
  phases: [{ title: 'Review' }],
}

const results = await parallel(args.map(pr => () =>
  agent(
    `/code-review スキルを使って PR #${pr.number} "${pr.title}" をレビューしてください。\n` +
    `URL: ${pr.url}\n` +
    `最新コミットSHA: ${pr.latestSha}\n` +
    `レビュー理由: ${pr.reason}\n\n` +
    `差分取得・チェック項目確認・PRコメント登録を実施し、` +
    `サマリーコメント末尾に <!-- claude-code-review reviewed-commit=${pr.latestSha} --> を必ず付与すること。`,
    { label: 'review:#' + pr.number, phase: 'Review' }
  )
))

return results.filter(Boolean)
```

Workflow 完了後、各PRの実行結果を Step 6 の完了報告に使用する。

### 6. 完了報告

全件レビュー後、以下を日本語でまとめて出力する:

- レビューしたPR件数と番号一覧
- スキップしたPR件数と番号一覧
- 各レビュー済みPRの判定（未レビュー / レビュー後変更あり）と auto_merge / needs_human_review の判定結果
