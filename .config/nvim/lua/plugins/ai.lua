return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                },
            })
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        build = "make tiktoken",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        config = function ()
            local select = require("CopilotChat.select")
            require("CopilotChat").setup({
                mappings = {
                    complete = {
                        insert = "",
                    },
                },
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
                        prompt =
                        "#git:staged\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
                    },
                    CommitStagedJa = {
                        prompt =
                        "#git:staged\nコミットメッセージをコミット規約に従って記述してください。タイトルは最大50文字、メッセージは最大200文字かつ72文字で折り返してください。",
                    },
                },
            })
        end,
    },

    {
        "robitx/gp.nvim",
        event = "VeryLazy",
        config = function ()
            local conf = {
                chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j><C-j>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-j>c" },
                openai_api_key = { "op", "read", "op://Personal/OpenAI/credential", "--no-newline" },
                hooks = {
                    Translator = function (gp, params)
                        local chat_system_prompt =
                        "You are a skilled translator with a deep understanding of both English and Japanese. Please translate the following English text into natural, fluent Japanese while preserving the context, nuance, and style of the original."
                        gp.cmd.ChatNew(params, chat_system_prompt)
                    end,
                },
            }
            require("gp").setup(conf)
        end,
        keys = {
            {
                "<Leader>cc",
                "<Cmd>GpChatToggle<CR>",
                mode = { "n", "x" },
                desc = "ChatGPT Toggle chat window",
            },
            {
                "<Leader>cn",
                "<Cmd>GpChatNew<CR>",
                mode = { "n", "x" },
                desc = "ChatGPT Create new chat window",
            },
            {
                "<Leader>ct",
                "<Cmd>GpTranslator vsplit<CR>",
                mode = { "n", "x" },
                desc = "ChatGPT call translate agent",
            },
        },
    },

    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        opts = {
            provider = "copilot",
            copilot = {
                model = "claude-3.5-sonnet",
                -- max_tokens = 4096,
            },
            hints = { enabled = false },
            windows = {
                width = 50,
            },
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "hrsh7th/nvim-cmp",
            "zbirenbaum/copilot.lua",
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        use_absolute_path = true,
                    },
                },
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}
