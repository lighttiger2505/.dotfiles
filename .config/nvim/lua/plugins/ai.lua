return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    -- auto_trigger = true,
                    -- keymap = {
                    --     accept = "<C-j>",
                    --     accept_word = false,
                    --     accept_line = false,
                    --     next = "<C-L>",
                    --     prev = "<M-[>",
                    --     dismiss = "<C-k>",
                    -- },
                },
            })
            -- local cmp = require("cmp")
            -- cmp.event:on("menu_opened", function()
            --     vim.b.copilot_suggestion_hidden = true
            -- end)
            -- cmp.event:on("menu_closed", function()
            --     vim.b.copilot_suggestion_hidden = false
            -- end)
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        cmd = {
            "CopilotChat",
            "CopilotChatOpen",
            "CopilotChatClose",
            "CopilotChatToggle",
            "CopilotChatStop",
            "CopilotChatReset",
        },
        build = "make tiktoken",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        opts = {
        },
        config = function()
            local select = require("CopilotChat.select")
            local context = require("CopilotChat.context")
            require('CopilotChat').setup({
                mappings = {
                    complete = {
                        insert = '',
                    },
                },
                prompts = {
                    ReviewBufferJa = {
                        prompt = 'このコードをレビューをしてください。',
                        selection = select.buffer,
                    },
                    ReviewSelectedJa = {
                        prompt = 'このコードをレビューをしてください。',
                        selection = select.visual,
                    },
                    DocsJa = {
                        prompt = '/COPILOT_GENERATE このコードを説明するドキュメントを記載してください。',
                        selection = select.visual,
                    },
                    PullRequestSummaryJa = {
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
                        prompt =
                        '#git:staged\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
                    },
                    CommitStagedJa = {
                        prompt =
                        '#git:staged\nコミットメッセージをコミット規約に従って記述してください。タイトルは最大50文字、メッセージは最大200文字かつ72文字で折り返してください。',
                    },
                },
            })
        end,
        keys = {
            {
                "<Leader>cc",
                "<Cmd>CopilotChat<CR>",
                mode = { "n", "x" },
                desc = "CopilotChat Open chat window",
            },
            {
                "<Leader>ca",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                mode = "n",
                desc = "CopilotChat Select prompt actions",
            },
        },
    },

    {
        "robitx/gp.nvim",
        config = function()
            local conf = {
                chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j><C-j>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>c" },
            }
            require("gp").setup(conf)
        end,
        keys = {
            {
                "<Leader>aa",
                "<Cmd>GpChatToggle<CR>",
                mode = { "n", "x" },
                desc = "ChatGPT Open chat window",
            },
        },
    }
}
