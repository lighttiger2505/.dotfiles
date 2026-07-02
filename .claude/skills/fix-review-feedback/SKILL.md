---
name: fix-review-feedback
description: 自分がauthor/assigneeのオープンPRのうち、レビューが実施され未解決の指摘があるものを列挙し、各指摘への対応方針を指摘ごとにユーザー確認しながらコード修正→コミット・プッシュまで行う。「自分のPRのレビュー指摘に対応して」「レビューコメントを直して」「指摘対応して」「PRの指摘をつぶして」などと依頼されたときに使う。
allowed-tools: Read, Grep, Glob, Bash, Edit, Write, AskUserQuestion, LSP, Agent
---

# 自分のPRのレビュー指摘に対応するスキル

自分が author または assignee になっているオープンPRのうち、レビューが実施され未解決の指摘が付いているものを列挙し、
指摘ごとにユーザーへ対応可否を確認したうえでコード修正・コミット・プッシュまでを行う。

**重要: レビュー指摘への対応（コード修正・コミット・プッシュ）は、必ず指摘ごとに `AskUserQuestion` でユーザーに確認してから実施すること。ユーザーの確認なしに修正・コミットを行ってはならない。**

## Step 1. リポジトリ・自分の login を取得する

```bash
gh repo view --json owner,name --jq '"owner=\(.owner.login) repo=\(.name)"'
gh api user --jq .login
```

以降、取得した `owner` / `repo` / `me`（login名）を使う。

## Step 2. 対象PRを列挙する

自分が assignee または author のオープンPRを2系統で取得し、PR番号で重複排除する。

```bash
gh search prs --assignee=@me --state=open \
  --json number,title,repository,url,isDraft,author --limit 50
gh search prs --author=@me --state=open \
  --json number,title,repository,url,isDraft,author --limit 50
```

- `repository.nameWithOwner` が現在のリポジトリ（`<owner>/<repo>`）と一致するものだけを対象にする（他リポジトリ・dependabot由来のPRは除外）
- 対象PRが0件の場合は「対応対象のPRなし」と報告してスキルを終了する

## Step 3. 各PRのレビュー実施状況を確認する

```bash
gh pr view <PR番号> --json number,title,headRefName,reviewDecision,reviews,latestReviews,url
```

- `reviews[]` に自分以外のレビュー（`COMMENTED` / `CHANGES_REQUESTED` / `APPROVED`）が1件以上あるPRのみ次のステップに進める
- `reviews[]` が空（レビュー未実施）のPRは対象から除外する

## Step 4. 未解決のレビュー指摘を収集する

REST APIの `pulls/comments` は解決済み（resolved）判定を含まないため、GraphQLの `reviewThreads` で未解決スレッドのみを抽出する。

```bash
gh api graphql -f query='
  query($owner:String!,$repo:String!,$num:Int!){
    repository(owner:$owner,name:$repo){
      pullRequest(number:$num){
        reviewThreads(first:100){
          nodes {
            isResolved
            isOutdated
            comments(first:20){
              nodes { author { login } body path line diffHunk }
            }
          }
        }
      }
    }
  }' -F owner=<owner> -F repo=<repo> -F num=<PR番号>
```

- `isResolved == false` のスレッドを「未対応の指摘」として収集する（`path` / `line` / `body` / `diffHunk` を保持する）
- inline に紐づかないレビュー全体へのコメント（`reviews[].body`）も、指摘として別途拾う
- 自分自身が投稿したスレッド・コメントは指摘対象から除外する

## Step 5. 対応対象PRの一覧を提示する

「レビュー実施済み かつ 未解決の指摘がある」PRのみを、以下の形式でMarkdownテーブルにまとめてユーザーに提示する。

| PR番号 | タイトル | reviewDecision | 未解決指摘数 | URL |
| --- | --- | --- | --- | --- |

未解決指摘のあるPRが0件の場合は、その旨を報告してスキルを終了する。

## Step 6. PRごとに指摘へ対応する

対象PRを1件ずつ、以下の手順で処理する。

### 6-1. 作業ツリーの確認とブランチ切り替え

```bash
git status --porcelain
```

- 未コミットの変更がある場合は処理を中断し、ユーザーにその内容を伝えて指示を確認する
- 作業ツリーがcleanであることを確認したうえで、対象PRのブランチに切り替える

```bash
git fetch origin <headRefName>
git switch <headRefName>
```

### 6-2. 指摘ごとに対応可否を確認する

Step 4で収集した未解決の指摘を1件ずつ提示し、以下を1つの単位として繰り返す。

1. 指摘内容（`path:line`、レビュアーのコメント本文、`diffHunk` の抜粋）と、こちらで考えた**対応方針案**を提示する
2. `AskUserQuestion` で対応可否を確認する（選択肢の例: 対応する / スキップする / 方針を変えて対応する）
3. 「対応する」が選ばれた場合:
   - `.claude/rules/go.md`（エラーは必ず明示的に扱う / 小さく責務の明確な関数を書く / グローバル状態を避ける / テーブル駆動テストを基本とする）および `CLAUDE.md` の実装時の注意に従ってコード修正する
   - 型に影響する変更を行った場合は `pnpm run type-check` を実行して型エラーがないことを確認する
   - **テストコードを新規作成・修正した場合は、Step 7 に進む前に `AskUserQuestion` でテスト実行の実施可否を確認する**（`CLAUDE.md` のテストガイドライン）。テスト実行後は結果（成功/失敗、テスト数）を明示的に報告する
4. 「方針を変えて対応する」が選ばれた場合は、ユーザーの指示に従って方針を修正してから対応する
5. 「スキップする」が選ばれた場合は、その指摘をスキップ一覧に記録し次の指摘に進む

このPRの全指摘を処理したら Step 6-3 に進む。

### 6-3. コミット・プッシュ

このPRで1件以上の指摘に対応した（差分がある）場合、`../commit-push-pr/SKILL.md` を読み、その手順に従ってコミット・プッシュを行う。

- 対象はこのPRの既存ブランチであり、新規PRを作成する必要はない（Step 6-1 で切り替えたブランチにそのままコミット・プッシュする）
- コミットメッセージには対応したレビュー指摘の要約を含める
- コミットメッセージの内容は、`commit-push-pr` skillの規約に従い実行前にユーザーに確認する

このPRで対応した指摘が0件（すべてスキップ）の場合はコミット・プッシュを行わず、次のPRに進む。

## Step 7. 完了報告

すべての対象PRを処理したら、PRごとに以下を日本語でまとめて報告する。

- 対応した指摘（件数・概要）
- スキップした指摘（件数・概要）
- コミット・プッシュの結果（コミットの有無、プッシュ先ブランチ）

## 注意点

- 対応対象は自分が author/assignee のPRのみ（レビュー依頼を受けているだけのPR・team宛のレビュー依頼は対象にしない）
- `develop` / `master` / `main` ブランチへの直接コミット・プッシュ・マージは行わない。既存PRのブランチへの修正コミットに限る
- 複数PRを跨いで処理する場合、PRを切り替える前に必ず作業ツリーがcleanであることを確認する
- 解決済み（resolved）のレビュースレッドは再提示しない
