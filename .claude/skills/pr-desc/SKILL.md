---
name: pr-desc
description: テンプレートにしたがって、Pull Requestの説明文を作成します。このとき過去のPull Requestを読み取りして考慮に入れます。
---

# Pull Requestの説明の作成

1. `gh pr view --json number,title,body,headRefName,baseRefName` を実行し、現在のPR情報を取得。
2. `git log $(gh pr view --json baseRefName -q .baseRefName)..HEAD --oneline` を実行し、コミット一覧を取得
3. `.github/PULL_REQUEST_TEMPLATE.md` を読み込み、テンプレートの形式を確認
4. `gh pr list --author @me --state merged --limit 5 --json number` を実行して直近でマージされたPR取得し、その後 `gh pr view <number> --json body` を実行して本文を確認し、スタイルの参考にする
5. テンプレートとスタイルに従ってPRのタイトルおよび説明文を作成
 - `<!-- コメント -->` などのコメントは削除
 - `> [!CAUTION]` などの注意書きは残す
 - `<details>` などのHTML要素は残す
 - `mermaid` などの図形は残す
6. `gh pr edit --title "<title>" --body "<description>"` を実行し、タイトルおよび説明文を更新
 - prが存在しないときは`gh pr create --title "<title>" --body "<description>" --draft --base develop`を実行して、新規作成する
 - 書き込みができないときは`<description>`をmarkdownに出力して終了する
 
# Pull Requestタイトルのルール

Pull Requestには変更概要を表すプレフィックス、その後の対応を判断するためのタグをつける

- 構造) {プレフィックス}({タグ}): {PR内容}
- 例) feature(impact): 配車履歴の検索機能の追加

## プレフィックス

修正内容を端的に示す識別子、下部のリストから選択する

```
feat     新機能の追加。APIやUIに新たな機能・オプションを導入
fix      バグ修正。既存機能の不具合対応や動作ミスの修正
perf     パフォーマンス改善。処理速度やメモリ使用量を最適化するコード変更
refactor リファクタリング（機能追加・バグ修正を伴わないコード構造の整理）。コードのモジュール化や重複排除など
style    コードの動作に影響しないスタイル変更。インデント、改行、セミコロンの追加・削除、フォーマット整形など
test     テストの追加・修正。ユニットテストや結合テストの新規作成、既存テストの修正
chore    ソースコードやテスト以外のファイル更新、プロジェクト構成やツール設定の更新など。.gitignore の編集、ビルドスクリプトの補正など
revert   以前のコミットを取り消す変更
build    ビルドシステムや外部依存関係に影響する変更。タスクランナーやバンドラの設定、npm・yarn依存ライブラリのアップデートなど
ci       CI用の設定ファイルやスクリプトの変更。GitHub Actionsなどのワークフロー設定
docs     ドキュメントのみの変更。README、Wiki、コメントの追記・修正など
```

## タグ

修正によって、プロダクトに与える影響を示す識別子、テンプレートに記載された`PRタグフローチャート`から判定する

```
impact すでに公開している画面の見た目が変わる。ないし事業者の運用内容が変わる。公開前の事前告知をしているなど、リリースすることで顧客に業務影響を与える変更についてタグを付ける。
featureflag フィーチャーフラグによる処理分岐を追加している場合、QAをしていないコードへの処理分岐が本番んで発生しないことを保証する必要性がある。そのため、リリース後にフィーチャーフラグによって隠蔽された機能が露出していないことを確認する必要性がある。
unpublished フィーチャーフラグなどによって事業者に対しては未公開になっている。
retest impactなどの事業者影響はないが、事業者に公開済みの機能に対して変更を加えており、再テストが必要。
none テスト追加やドキュメント追加やCIの改善など、事業者に対しては影響を与えない変更。
```
