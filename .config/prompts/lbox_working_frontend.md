現状あなた(ClaudeCode)はコンテナ上で動作しています。
コンテナの定義は`.lbox/compose.sandbox.yml`にあり、ClaudeCodeが動作しているのは`sandbox`というコンテナです。
コンテナで起動したClaudeCodeから以下の作業が問題なく動作することを確認してください。
動作しなかった場合、その原因を教えてください。

- **重要: 一番最初に新しいworktreeを作る**
- TypeScript/Reactの環境
    - [ ] buildができること(pnpm build)
    - [ ] lintが実行できること(pnpm lint)
    - [ ] 単体テストが実行できること(pnpm test)
    - [ ] storybookテストが実行できること(pnpm test-storybook:ci)
- Gitの環境
    - [ ] Git操作ができること
    - [ ] ghコマンドによるGitHubアクセスができること
- ClaudeCodeプラグインの動作
    - [ ] typescript-lspプラグインを利用してtypescript-lspの情報にアクセスできること
    - [ ] context7プラグインを利用して何らかの情報にアクセスできること
    - [ ] Confluenceへアクセスできること
        - https://mo-t.atlassian.net/wiki/spaces/Aiauto/pages/1798996204/GO
    - [ ] Figmaへアクセスできること
        - https://www.figma.com/design/nP4pLdsM1sohRmzpOVIUr4/GO%E7%AE%A1%E7%90%86%E7%94%BB%E9%9D%A2?node-id=17602-15202&t=IJrLPn3XqNqCPlyg-1
