return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                copilot_model = "gpt-4o-copilot",
                suggestion = {
                    enabled = true,
                },
                copilot_node_command = vim.fn.system("mise which node"):gsub("\n", ""),
            })
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        branch = "main",
        build = "make tiktoken",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local select = require("CopilotChat.select")
            require("CopilotChat").setup({
                model = "claude-3.7-sonnet",
                prompts = {
                    PullRequestReviewJa = {
                        prompt = [=[
コードレビューをお願いします。アウトプットは以下の内容を簡潔に列挙してください。
- 変更内容の要約: 内容の要約は100文字以内、1,2文でまとめてください
- 変更内容の詳細: 変更内容の詳細を箇条書きで詳しく記載してください
- レビュー内容: 以下の内容観点でレビューをお願いします。指摘箇所はどの部分かわかるようにリポジトリルールからの相対ファイルパスとコードの行、列と一緒に記載してください。
    - コードで改善するべき箇所を教えてください
    - 複雑で可読性の低いロジックをよりシンプルにする方法があれば教えてください
    - 変更によってバグが発生していれば教えてください
    - おかしな命名ないしタイポがあれば教えてください
    - コメントを記載することでより文脈がわかりやすくなる箇所があれば教えてください
                        ]=],
                        selection = select.buffer,
                    },
                    CommitStagedEn = {
                        prompt = [=[
"#git:staged
Write commit message for the change with commitizen convention.
Make sure the title has maximum 50 characters and message is wrapped at 72 characters.
Wrap the whole message in code block with language gitcommit.
                        ]=],
                    },
                    CommitStagedJa = {
                        prompt = [=[
git:staged
コミットメッセージをコミット規約に従って記述してください。
タイトルは最大50文字、メッセージは最大200文字かつ72文字で折り返してください。
                        ]=],
                    },
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
