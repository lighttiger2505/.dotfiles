return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                -- copilot_model = "gpt-4o-copilot",
                suggestion = {
                    enabled = true,
                },
            })
        end,
    },

    {
        "olimorris/codecompanion.nvim",
        cmd = { "CodeCompanionChat" },
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                ignore_warnings = true,
                adapters = {
                    http = {
                        copilot = function()
                            return require("codecompanion.adapters").extend("copilot", {
                                schema = {
                                    model = {
                                        -- default = "gpt-4.1",
                                        -- default = "claude-3.7-sonnet",
                                        default = "claude-sonnet-4",
                                    },
                                },
                            })
                        end,
                    },
                },
                strategies = {
                    chat = {
                        adapter = "copilot",
                        keymaps = {
                            send = {
                                modes = { n = "<CR>", i = "<C-s>" },
                            },
                            close = {
                                modes = { n = "q", i = "<Nop>" },
                            },
                        },
                    },
                    inline = {
                        adapter = "copilot",
                    },
                    cmd = {
                        adapter = "copilot",
                    },
                },
                prompt_library = {
                    -- https://github.com/olimorris/codecompanion.nvim/discussions/694
                    ["Custom Commit Message"] = {
                        strategy = "chat",
                        description = "Generate a custom commit message",
                        opts = {
                            short_name = "custom_commit_message",
                            auto_submit = true,
                        },
                        prompts = {
                            {
                                role = "user",
                                content = function()
                                    return string.format(
                                        [=[
#{buffer}

MUST: Commit messages should follow the language of the commit template.

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```

When unsure about the module names to use in the commit message, you can refer to the last 20 commit messages in this repository:

```
%s
```

Output only the commit message without any explanations and follow-up suggestions.
]=],
                                        vim.fn.system("git diff --no-ext-diff --staged"),
                                        vim.fn.system('git log --pretty=format:"%s" -n 20')
                                    )
                                end,
                                opts = {
                                    contains_code = true,
                                },
                            },
                        },
                    },
                    ["Custom Pull Request Review"] = {
                        strategy = "chat",
                        description = "Review a pull request",
                        opts = {
                            short_name = "custom_review_pull_request",
                            auto_submit = false,
                        },
                        prompts = {
                            {
                                role = "user",
                                content = function()
                                    return string.format(
                                        [=[
#{buffer}

コードレビューをお願いします。アウトプットは以下の内容を簡潔に列挙してください。
- 変更内容の要約: 内容の要約は100文字以内、1,2文でまとめてください
- 変更内容の詳細: 変更内容の詳細を箇条書きで詳しく記載してください
- レビュー内容: 以下の内容観点でレビューをお願いします。指摘箇所はどの部分かわかるようにリポジトリルールからの相対ファイルパスとコードの行、列と一緒に記載してください。
    - コードで改善するべき箇所を教えてください
    - 複雑で可読性の低いロジックをよりシンプルにする方法があれば教えてください
    - 変更によってバグが発生していれば教えてください
    - おかしな命名ないしタイポがあれば教えてください
    - コメントを記載することでより文脈がわかりやすくなる箇所があれば教えてください

レビューのコンテキストに悩んだ場合、このリポジトリの直近20件のコミットメッセージを参照してください。

```
%s
```

]=],
                                        vim.fn.system('git log --pretty=format:"%s" -n 20')
                                    )
                                end,
                                opts = {
                                    contains_code = true,
                                },
                            },
                        },
                    },
                },
            })
        end,
        keys = {
            {
                "<Space>a",
                "<cmd>CodeCompanionActions<cr>",
                mode = { "n", "v" },
                desc = "CodeCompanion select code companion actions",
            },
            {
                "<Leader>aa",
                "<cmd>CodeCompanionChat Toggle<cr>",
                mode = { "n", "v" },
                desc = "CodeCompanion toggle codecompanion chat",
            },
            {
                "<Leader>an",
                "<cmd>CodeCompanionChat<cr>",
                mode = { "n", "v" },
                desc = "CodeCompanion new codecompanion chat",
            },
            {
                "ga",
                "<cmd>CodeCompanionChat Add<cr>",
                mode = { "v" },
                desc = "CodeCompanion add codecompanion chat",
            },
        },
    },
}
