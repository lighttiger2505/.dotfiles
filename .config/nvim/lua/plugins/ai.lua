return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
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
