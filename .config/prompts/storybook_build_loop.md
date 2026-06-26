  「カバレッジ閾値達成まで」ループを開始する。

  ## 前提・準備（最初に一度だけ）

  - 調査・作業は必ず **`origin/develop` の最新** を基準とする。ローカルの develop は古い可能性があるため、最初に `git fetch origin develop` を実行すること（ローカル基準で探索しないこと）。
  - **優先順位:** 事業者向け（company）機能をインターナル向け（internal）より優先する。判定は「`src/routes/` から参照されている = 事業者向け」「`src/apps/internal/` からのみ参照 = インターナル向け」。そのうえでStoryファイルが存在しない画面を優先する。
  - 陣頭指揮はopusを利用して、テストの実装はsonnetを利用すること、テストとPR作成はそれぞれ別のサブエージェントが実施し、コンテキストを分離すること

  ## ゴール

  - `src/features/` 配下の各ディレクトリについて、テストが整備され十分なカバレッジが確保されていること。
      - 全テストがパスし、**当該ディレクトリの lines カバレッジが 70% 以上**であること（判定は全体ではなくディレクトリ単位）。
          - 補足: lines を主指標とする。`index.ts` 等の単純 re-export は関数/行が少なく集計を押し下げるため判定から除外してよい。
      - 画面・フォーム・ダイアログなどUI挙動は **Storybook + play 関数**で検証する。
      - 多くのフィーチャーは `validate.test.ts` 等を既に保有している。その場合は不足している **Storybook テストの追加**に集中する（重複作成しない）。

  ## カバレッジの測定方法（重要）

  - vitest の `root` が `src` のため、coverage は **`src/coverage/coverage-summary.json`** に出力される（リポジトリ直下の `coverage/` は別環境の古い成果物の可能性があるため参照しない）。
  - `--project=storybook` と `--project=unit` は coverage を**互いに上書きする**。ディレクトリの合算カバレッジは、両方を実行して `coverage-summary.json` を**ファイルごとに covered の大きい方を採用してマージ**して算出する（ユニットは validate
  等、Storybook は UI を別々にカバーするため）。
  - 各イテレーションのチェックコマンド（`{dir_name}` は対象ディレクトリ）:
      - Story: `STORY_PATH='../src/features/{dir_name}/**/*.stories.@(ts|tsx)' pnpm exec vitest run --project=storybook --coverage`
      - Vitest: `CI=true TZ=Asia/Tokyo pnpm exec vitest run src/features/{dir_name} --project=unit --coverage`
      - ※ いずれも `vitest run`（または `CI=true`）で実行すること。`vitest` 単体は watch モードで終了しない。
  - 実装完了後は `pnpm run type-check` で型エラーが無いことを確認する。

  ## 最大イテレーション数

  - 12。ただしブラウザテストは1回あたり数十秒かかるため、**1ターンで2〜3件処理したらチェックポイントとして報告し、継続可否を確認する**こと（無言で全件を一気に回さない）。

  ## 処理内容（1イテレーション）

  1. `origin/develop` 基準で、事業者向けかつ `*.stories.tsx` が無い／カバレッジの低い `src/features/` 配下ディレクトリを1つ選ぶ。規模が小さく 70% 到達が現実的なものを優先する。
  2. 同一 worktree 内で `origin/develop` から作業ブランチを切る（ブランチ名は `git-branch-naming` に従い `test/<feature>-coverage`）。
  3. 対象ディレクトリの実装を読み、API エンドポイント・swr フック・フォーム/ダイアログ構成を把握する。既存の類似フィーチャーの stories をテンプレートとして踏襲する。
  4. テストを追加し、上記チェックコマンドで合算カバレッジを測定。**lines 70% 以上**かつ全テスト終了コード0になるまでテストを追加・修正する。
  5. 完了条件を満たしたら `/commit-push-pr` スキルでドラフトPR（base: `develop`）を作成する。
  6. ブランチはそのまま（worktree は次イテレーションで再利用するため削除しない）。最後のイテレーション後に必要なら worktree を削除する。

  ## Storybook play 関数の既知パターン（踏襲して試行回数を減らす）

  - combobox/Autocomplete は**オプションの読込完了（要素が enabled）を待ってから**クリック・選択する。
  - MUI Dialog はポータル（document.body 直下）に描画されるため、ダイアログ内要素は `within(canvasElement)` ではなく `screen` で取得する。
  - `apiError` はエラーレスポンスでも `resp.clone().json()` するため、失敗系の MSW モックは **JSON ボディ付き**で返す（空ボディ 500 は不可）。
  - 汎用 `DateForm` は MUI `DatePicker`（format 表示）であり、`fireEvent.change` に ISO 文字列を渡しても反映されない。日付入力に頼らず初期値で検証するか、ピッカー操作を用いる。
  - 編集画面など `useParams` を使うページは `storybook-addon-remix-react-router` の `reactRouterParameters`（`location.pathParams` / `routing.path`）でルートパラメータを与える。
  - API モックは `@/__mocks__/handlers` の `overrideHandlers` で上書きする。アイコンのみのボタン（アクセシブル名無し）は行要素から `getAllByRole("button")` で特定する。

  ## ステータス報告

  - 各イテレーション後にチェックコマンドを実行し、出力を読み、終了条件が満たされていない場合のみ続行する。
  - 各パスごとに「フィーチャー名・区分（事業者/インターナル）・PR番号・テスト数・合算カバレッジ(lines/funcs/branch)」を簡潔に報告する。
  - 終了条件がパスするか、最大イテレーション数に達した時点で停止する。

  ## ガードレール（省略不可）

  - 成功を強制するためにチェックコマンドや終了基準を変更しないこと。
  - 終了条件をパスさせるためにチェックをスキップ・無効化・回避しないこと。
  - カバレッジ閾値の判定対象（lines / 合算 / re-export 除外）を、達成のために都合よく変更しないこと。
  - 数イテレーション後も行き詰まった場合は、メトリクスを不正に操作せず、停止してブロッカーを報告すること。
  - テストを弱体化・削除・スキップしてスイートをグリーンにしないこと。
  - 実際のアサーションを、常にパスするだけの形骸的なテストに置き換えないこと。
  - テストを取り繕うより、プロダクションコードの修正を優先すること。
