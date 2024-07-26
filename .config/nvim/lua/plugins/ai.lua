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
        cmd = {
            "CopilotChat",
            "CopilotChatOpen",
            "CopilotChatClose",
            "CopilotChatToggle",
            "CopilotChatStop",
            "CopilotChatReset",
        },
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        opts = {
        },
        config = function()
            local select = require('CopilotChat.select')
            require("CopilotChat.integrations.cmp").setup()
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
                    CommitStagedEn = {
                        prompt =
                        'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message should be a maximum of 200 characters and wrap at 72 characters. Wrap the whole message in code block with language gitcommit. As simply as possible.',
                        selection = function(source)
                            return select.gitdiff(source, true)
                        end,
                    },
                    CommitStagedJa = {
                        prompt =
                        'コミットメッセージをコミット規約に従って記述してください。タイトルは最大50文字、メッセージは最大200文字かつ72文字で折り返してください。',
                        selection = function(source)
                            return select.gitdiff(source, true)
                        end,
                    },
                },
            })
        end,
        keys = {
            {
                "<Leader>cc",
                "<Cmd>CopilotChat<CR>",
                mode = "n",
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

}
