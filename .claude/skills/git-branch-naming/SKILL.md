---
name: git-branch-naming
description: Gitブランチを新規作成するときの命名規約。`git checkout -b` / `git switch -c` / `git worktree add` でブランチを作る直前、またはユーザーにブランチ名を提案・確認するときは必ずこのskillを参照する。Conventional Commits準拠の type prefix（feat/fix/perf/refactor/style/test/chore/revert/build/ci/docs）と、kebab-case の `<type>/<description>` 形式に従う。ブランチ・branch・worktree・「ブランチ切って」などの語が出たら作業前に確認すること。
---

# Git ブランチ命名規約

ブランチを新規作成する前に、この規約に沿った名前を決める。勝手に独自フォーマットを使わない。

## 基本フォーマット

```
<type>/<description>
```

- `<type>`: 下の表から、変更内容に最も合うものを **1つ** 選ぶ
- `<description>`: 変更内容を表す短い英語の説明。**kebab-case（小文字＋ハイフン区切り）**
- 区切りは `type` と `description` の間がスラッシュ、`description` 内の単語間がハイフン

```
feat/payment-refund
fix/login-timeout
refactor/remove-unused-service-main-db
chore/update-dependabot
```

issue / チケット番号を紐づける運用がある場合は description の先頭に付与してよい（任意）。

```
feat/PROJ-1234-payment-refund
fix/1234-login-timeout
```

## type 一覧

変更の **目的** で選ぶ。複数該当する場合は「その変更の主目的」を優先する（例: パフォーマンス目的のリファクタなら `perf`、構造整理が主なら `refactor`）。

| type | 用途 |
|----------|------|
| `feat` | 新機能の追加。API や UI に新たな機能・オプションを導入 |
| `fix` | バグ修正。既存機能の不具合対応や動作ミスの修正 |
| `perf` | パフォーマンス改善。処理速度やメモリ使用量を最適化するコード変更 |
| `refactor` | リファクタリング（機能追加・バグ修正を伴わないコード構造の整理）。モジュール化や重複排除など |
| `style` | コードの動作に影響しないスタイル変更。インデント、改行、セミコロンの追加・削除、フォーマット整形など |
| `test` | テストの追加・修正。ユニットテストや結合テストの新規作成、既存テストの修正 |
| `chore` | ソースコードやテスト以外のファイル更新、プロジェクト構成やツール設定の更新。`.gitignore` 編集、ビルドスクリプト補正など |
| `revert` | 以前のコミットを取り消す変更 |
| `build` | ビルドシステムや外部依存関係に影響する変更。タスクランナーやバンドラ設定、npm・yarn 依存ライブラリのアップデートなど |
| `ci` | CI 用の設定ファイルやスクリプトの変更。GitHub Actions などのワークフロー設定 |
| `docs` | ドキュメントのみの変更。README、Wiki、コメントの追記・修正など |

## 命名ルール

- **すべて小文字**。大文字小文字を区別しないファイルシステム（macOS など）での衝突事故を防ぐ。
- **単語区切りはハイフン**（kebab-case）。スネークケース・キャメルケースは使わない。
- **簡潔に、内容が分かる名前**にする。長すぎる文章にしない（目安: 単語3〜5語程度）。
- `git check-ref-format` の制約に従う。次は使用不可: 末尾スラッシュ、連続スラッシュ、空白、`~ ^ : ? * [ \`、`..`、`@{`、先頭の `.`、末尾の `.lock`。
- `main` / `master` / `develop` / `release/x.y.z` は基本ブランチ・予約的な名前なので、作業ブランチ名として使わない。

## type プレフィックスと階層衝突の注意

`feat` というブランチと `feat/foo` というブランチは **同時に存在できない**（Git の内部 ref はファイルパスとして扱われ、`feat`（ファイル）と `feat/`（ディレクトリ）が衝突する）。type は必ず階層プレフィックスとして使い切り、`<type>` 単体のブランチは作らない。

## 既存リポジトリでの優先順位

リポジトリに `CONTRIBUTING.md` / `CLAUDE.md` などで明文化されたブランチ規約がある場合は、**そちらを最優先**する。明文化がない場合でも、`git branch -a` で既存ブランチの命名傾向を確認し、明らかに別の慣習が定着しているならそれに合わせる。この skill はデフォルトの拠り所であって、プロジェクト固有ルールを上書きするものではない。

## 適用例

**例1:** 決済の返金機能を新しく追加する
→ `feat/payment-refund`

**例2:** ログイン時にタイムアウトが発生するバグを直す
→ `fix/login-timeout`

**例3:** 未使用の ServiceMainDB 参照を削除して構造を整理する（機能変更なし）
→ `refactor/remove-unused-service-main-db`

**例4:** GitHub Actions のブランチ同期ワークフローを修正する
→ `ci/branch-sync-workflow`

**例5:** Dependabot 経由で依存ライブラリを更新する
→ `build/bump-dependencies`（プロジェクトによっては `chore/` 運用もあるため、既存傾向に合わせる）
