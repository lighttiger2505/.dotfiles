現状あなた(ClaudeCode)はコンテナ上で動作しています。
コンテナの定義は`.lbox/compose.sandbox.yml`にあり、ClaudeCodeが動作しているのは`sandbox`というコンテナです。
コンテナで起動したClaudeCodeから以下の作業が問題なく動作することを確認してください。
動作しなかった場合、その原因を教えてください。

- **重要: 一番最初に新しいworktreeを作る**
- Golangの環境
    - [ ] go buildができること(make build)
    - [ ] golangci-lintが実行できること(make lint)
    - [ ] Golangのユニットテストが実行できること(go test ./internal/application/ -run TestCarHandler_Find)
- Gitの環境
    - [ ] Git操作ができること
    - [ ] ghコマンドによるGitHubアクセスができること
- Gitの環境
    - [ ] BrunoによるE2Eテストができること
- ClaudeCodeプラグインの動作
    - [ ] gopls-lspプラグインを利用してgoplsの情報にアクセスできること
    - [ ] context7プラグインを利用して何らかの情報にアクセスできること
    - [ ] Confluenceへアクセスできること
        - https://mo-t.atlassian.net/wiki/spaces/Aiauto/pages/1798996204/GO
    - [ ] Figmaへアクセスできること
        - https://www.figma.com/design/nP4pLdsM1sohRmzpOVIUr4/GO%E7%AE%A1%E7%90%86%E7%94%BB%E9%9D%A2?node-id=17602-15202&t=IJrLPn3XqNqCPlyg-1
