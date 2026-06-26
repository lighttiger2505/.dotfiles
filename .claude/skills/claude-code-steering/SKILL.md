---
name: claude-code-steering
description: Claude Code の挙動を指示・カスタマイズする方法（CLAUDE.md / rules / skills / subagents / hooks / output styles / append-system-prompt）の選び方ガイド。「この指示をどこに書くべきか」「CLAUDE.md が肥大化してきた」「毎回必ず lint を走らせたい」「特定ディレクトリだけに適用したい」「context を節約したい」「絶対にやらせたくない操作がある」といった、Claude Code の設定・運用方針を決めるとき、または CLAUDE.md / rules / skill / subagent / hook を新規作成・整理するときに必ず参照する。Claude Code のセットアップやベストプラクティスの話題が出たら、ユーザーが明示的に「スキルを使って」と言わなくても発動する。
---

# Claude Code Steering ガイド

Claude Code には、Claude の挙動を指示する手段が **7 種類** ある。それぞれ「いつ context に読み込まれるか」「compaction（圧縮）後に残るか」「context コスト」「指示としての強制力」が異なる。**目的に合った手段を選ぶこと自体が最も重要** であり、間違った場所に書くと token を浪費し、肝心な指示の遵守率も下がる。

このスキルは「その指示をどこに書くべきか」を判断するための早見表・意思決定フレーム・各手段の詳細をまとめたもの。

## 7 つの手段 早見表

| 手段 | 読み込まれるタイミング | compaction 後の挙動 | context コスト | 使いどころ |
| --- | --- | --- | --- | --- |
| **CLAUDE.md（root）** | セッション開始時。セッション中ずっと残る | memoize される。1 度読んでキャッシュ、compaction 後に再読込 | 高。関連有無に関わらず全行が token を消費 | build コマンド、ディレクトリ構成、monorepo 構造、コーディング規約、チーム規範 |
| **CLAUDE.md（サブディレクトリ）** | そのディレクトリ配下のファイルを Claude が読んだ時にオンデマンド | 触られるまで失われる | 低。該当ディレクトリ作業時のみ消費 | 特定サブディレクトリ固有の規約 |
| **Rules** | session 開始時（user-level）、または対象ファイルに触れた時のみ（path-scoped） | compaction 時に再注入 | 中。path-scoped でなければ常時オン | 特定の制約・規約（例：API handler は Zod で入力検証） |
| **Skills** | name と description は session 開始時。本体は呼び出された時 | 呼ばれた skill は共有予算内で再注入。古いものから drop | 低。本体は呼び出し時のみ。skill 間で token 予算を共有 | 手順的なワークフロー（deploy / release チェックリスト） |
| **Subagents** | name・description・tool 一覧は session 開始時。本体は Agent tool 経由で呼ばれた時のみ | 最終メッセージ（要約＋メタデータ）だけが親に戻る | 低。呼ばれるまで main context のコストゼロ。独立した context window で動く | 並行作業や分離したい副タスク（深い検索、ログ解析、依存監査） |
| **Hooks** | ライフサイクルイベントで発火 | compaction を完全にバイパス | 低。設定は main context 外。一部の出力のみ戻る（例：ブロックエラー） | 決定論的な自動化（lint 実行、完了時 Slack 通知、コマンドのブロック、PreCompact での履歴バックアップ） |
| **Output styles** | session 開始時。system prompt に注入 | compaction されない | 高。context を占有するがデフォルト system prompt を上書き | 役割の大きな変更（コーディング助手 → 汎用助手） |
| **append-system-prompt** | session 開始時。CLI フラグで渡す | compaction されない。その invocation のみ適用 | 中。session 内で初回リクエスト後にキャッシュ | トーン、応答長、フォーマットの好み |

## まず読むべき意思決定フレーム（アンチパターン検出）

以下のことをしていたら、書く場所が間違っている可能性が高い。

**「X したら必ず Y する」を CLAUDE.md に書いている**
→ 確実に起こすべきなら **hook**（`settings.json`）にする。「モデルが formatter を実行するか選ぶ」のと「formatter が自動で走る」のは別物。例：編集後の prettier、完了時の Slack 通知。

**「絶対に〜するな」を CLAUDE.md に書いている**
→ 指示は不適切。Claude はたいてい従うが、長い session・曖昧な状況・タスク中に読んだファイルからの prompt injection 等で破られうる。本物の guardrail は決定論的でなければならず、それは **hook** と **permissions**。`PreToolUse` hook は呼び出しを検査し exit code 2 でブロックできる。組織全体に強制したいなら **managed settings**（admin がデプロイ、ユーザーのローカル設定で上書き不可）が唯一の確実な方法。

**30 行の手順を CLAUDE.md に書いている**
→ 手順は **skill** に置く。CLAUDE.md は常に保持すべき「事実」（build コマンド、monorepo 構成、チーム規約）のためのもの。deploy runbook やセキュリティレビューのチェックリストは `.claude/skills/` に置けば、呼ばれた時だけ本体が読み込まれる。

**API 固有の rule を paths なしで書いている**
→ `src/api/**` だけに適用される rule なら `paths:` で scope すれば、無関係な作業中は context から外れる。scope なしの rule は CLAUDE.md に書くのと機構的に同じ（常に読み込まれ、常に token を消費）。

**個人の好みをプロジェクトの CLAUDE.md に書いている**
→ 全ファイル系手段には user-level の対応物があり、どのリポジトリでも読み込まれる。個人の好み（例：常に semantic commit message）は user-level のローカルファイルへ。プロジェクトの CLAUDE.md は「チーム共通かつそのコードベース固有」の設定のために残す。

## 各手段の詳細とコツ

### CLAUDE.md ファイル

プロジェクトルートの markdown。session 開始時に読み込まれ、ずっと残る。build コマンド、ディレクトリ構成、monorepo 構造、コーディング規約、チーム規範に向く。2 種類あり挙動が異なる：

- **常時読み込み（root）**：共有リポジトリの root CLAUDE.md、および/または個人用のローカルファイル。session 開始時に読み込まれ、長い session でも失われない。compaction 時に再読込される。
- **オンデマンド（サブディレクトリ）**：session を初期化したフォルダより下の CLAUDE.md。例：`app/api/CLAUDE.md` は `app/api` 配下のファイルを読んだ時に読み込まれる。path-scoped rule と同じく、そのディレクトリを再び触るまでは context から消える。

共有リポジトリでは、CLAUDE.md は持ち主のいない config ファイルと同様に肥大化しやすい。各チームが追記し、誰も削除しないため、スケールするとコストが積み重なる。全エンジニアの全 session に、関係の有無に関わらず全行が読み込まれ、token を消費し、本当に重要な指示の遵守率を薄める。

**コツ**：
- CLAUDE.md は **200 行以内** に保ち、オーナーを決め、コードと同様にレビューする。
- このファイルは「コードベースの概要」、あるいは「必要に応じて Claude が詳細を見に行く他ファイルへの索引」と考える。
- 肥大化したら、チーム固有の規約は path-scoped rule へ、手順は skill へ押し出す。
- monorepo では各チームのディレクトリに専用のサブディレクトリ CLAUDE.md を置き、`claudeMdExcludes` 設定で触れないチームのファイルを除外できる。
- 全リポジトリに必須の標準（セキュリティポリシー、コンプライアンス）は、MDM や config 管理で配布する中央管理 CLAUDE.md にすれば、個人設定で除外できない。

### Rules

`.claude/rules/` 内の markdown で、特定の制約・規約を与える。

scope なしの rule は CLAUDE.md と同様、session 開始時に常に読み込まれ compaction 時に再注入される。タスクと無関係でも context を消費し token を無駄にする。

path-scoped rule は frontmatter に `paths` を加えることで、関連する時だけ読み込める。例：`src/api/**` に scope した rule は docs だけの session では context に入らず、`src/api/` 配下のファイルを読んだ時だけ読み込まれる。

```yaml
---
paths:
  - "src/api/**"
  - "**/*.handler.ts"
---
All API handlers must validate input with Zod before processing.
```

**コツ**：「migration は append-only」のようなファイル固有の制約は、`paths:` frontmatter を付けた **rule** が最適。コードベースの複数箇所（ただし全部ではない）に現れる横断的関心事やファイルに関する指示なら、ネストした CLAUDE.md より path-scoped rule を選ぶ。

### Skills

`.claude/skills/` に置く、指示・スクリプト・リソースのフォルダ。各 skill は name・description・本体を持つ `SKILL.md` を含む。

session 開始時には name と description だけが読み込まれ、本体は Claude が skill を呼び出した時（slash command 例 `/code-review`、またはタスクへの自動マッチ）に読み込まれる。

compaction 時は、呼ばれた skill が全 skill 共有の総予算内で再注入される。session 中に多くの skill を呼んでいた場合、古いものから drop される。

**コツ**：deploy ワークフロー、release チェックリスト、レビュープロセスなど **手順的な指示は CLAUDE.md ではなく skill** に置く。Claude Code には組み込み skill があるが、自作もできる。

### Subagents

`.claude/agents/` 内の markdown で、特定の副タスク用の隔離された assistant を定義する。各ファイルは YAML frontmatter（name、description、任意で model や tool アクセス）＋本体（その subagent の system prompt になる）。

skill と同様に name・description・tool 一覧は session 開始時に読み込まれるが、本体は自動発動しない。Claude が Agent tool 経由で prompt 文字列を渡して呼ぶ。本体の大きな指示 context は **親の会話に一切入らない**。subagent は新しい独立した context window で動き、戻ってくるのは最終メッセージ（多くの場合サブタスクの集約結果）＋メタデータだけ。

このパターンはスケールする：subagent は 5 階層までネストでき、dynamic workflows は数十〜数百のバックグラウンド agent を、各詳細を指定せずにオーケストレーションできる。オーケストレーション計画や中間結果は Claude の context ではなくスクリプト変数に置かれるため、指示の忠実さを失わずスケールできる。

**コツ**：この隔離性こそが、skill ではなく subagent を選ぶ主な理由。深い検索、ログ解析、依存監査のように、後で参照しない中間結果でメインの会話を散らかしたくない副タスクは subagent。逆に、各ステップを見て操舵したい手順はメインスレッドで進む skill にする。

### Hooks

Claude のライフサイクル上の特定イベント（ファイル編集、tool 呼び出し、session 開始など）で発火する、ユーザー定義のコマンド・HTTP エンドポイント・LLM prompt。`settings.json`、managed policy settings、または skill/agent の frontmatter で登録する。

種類は command / HTTP / mcp_tool / prompt / agent の 5 つ。すべて決定論的にトリガーされる。前 3 つは決定論的に実行され、後ろ 2 つ（prompt と agent）はルールではなく Claude の判断で出力を決める。

設定や指示が main context window の外にあるため context コストは低い。harness が handler を実行する（command / http / mcp_tool）か、別 window でモデル呼び出しを行う（prompt / agent）。一部の hook は出力が main context に保存される（例：ブロック hook の標準エラーは、なぜ拒否されたか Claude が分かるよう保存される）。ただし大半の hook は明示的に返さない限り出力は保存されない。これが CLAUDE.md・rules・skills と本質的に異なる点。

**コツ**：決定論的に起こすべきことは hook を使う。編集後の lint、完了時の Slack 通知、特定コマンドのブロックなど。`PreToolUse` hook は任意の tool 呼び出しを検査し exit code 2 で拒否できる。hook は「Claude に読み込ませる指示」ではなく「harness が実行するコード」なので context コストが低い。

### Output styles

`.claude/output-styles/` 内のファイルで、system prompt に指示を注入する。compaction されず、毎 session 開始時に読み込まれ、session 内初回リクエスト後にキャッシュされる（context コストは中）。

system prompt に座るため、ここまでの手段の中で **最も指示遵守の重みが高い**。慎重に使うこと。

**output style の変更はデフォルトの output style を置き換える**（frontmatter に `keep-coding-instructions: true` を設定しない限り）。Claude Code ではこれにより、「ソフトウェアエンジニアリングを支援している」という指示や、変更スコープの決め方、コメントの付与/省略、セキュリティ上の懸念への対応、完了宣言前のテスト実行といった検証習慣など、重要なデフォルト指示が外れる。デフォルトでは custom output style はこれら全てを落とし、Claude Code はエンジニア助手というより汎用助手になる。

**コツ**：custom output style を書く前に組み込みスタイルを確認する。**Proactive**（自律性）、**Explanatory**（教育モード）、**Learning**（協働コーディング）が最も一般的なニーズをカバーしており、スタイルファイルを保守せずに済む。

### append-system-prompt

output style を変更する代わりの手段で、`append-system-prompt` フラグを使う。output style ファイルの変更は Claude の挙動に大きく意図しない変化を起こしうるが、append フラグは元の system prompt に **追加するだけ**。役割は変えず、デフォルトの役割に指示を足す。invocation 時に渡され、その invocation のみに適用される（ファイルとして session を跨いで永続化されない）。

他手段より context コストは高めになりうる：input token が増える（ただし prompt caching で初回後は軽減）。冗長/長文スタイルを指示すると output token も増える。

**コツ**：特定のコーディング標準、出力フォーマット、ドメイン知識の追加に向く。ただし遵守率には逓減があり、一般にこの方法で指示を増やすほど（特に矛盾する指示があるほど）厳密には従わなくなる。

## まとめ：選択の指針

- **事実・概要** → CLAUDE.md（root は常時、サブディレクトリは局所）
- **特定ファイル/パスの制約** → path-scoped rule
- **手順・チェックリスト** → skill
- **隔離して回す副タスク** → subagent
- **決定論的に必ず起こす/絶対に止める** → hook（＋組織強制は permissions / managed settings）
- **役割の大変更** → output style（組み込みで足りないか先に確認）
- **トーン・フォーマットの軽い追加** → append-system-prompt

幾つか動き出したら、skill・subagent・hook・output style を **plugin** にまとめてチームやプロジェクト間で共有できる。
