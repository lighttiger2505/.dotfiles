---@module "lazy"
---@type LazySpec
return {
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        version = "1.*",
        dependencies = {
            "mikavilpas/blink-ripgrep.nvim",
            "fang2hou/blink-copilot",
            "rafamadriz/friendly-snippets",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = {
                    "snippet_forward",
                    function() -- sidekick next edit suggestion
                        return require("sidekick").nes_jump_or_apply()
                    end,
                    function() -- if you are using Neovim's native inline completions
                        return vim.lsp.inline_completion.get()
                    end,
                    "fallback",
                },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 50,
                    window = { border = "single" },
                },
                menu = {
                    border = "single",
                    draw = {
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                    },
                },
            },
            signature = {
                enabled = true,
                window = { border = "single" },
            },
            sources = {
                default = function()
                    local success, node = pcall(vim.treesitter.get_node)
                    if
                        success
                        and node
                        and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
                    then
                        return {
                            "copilot",
                            "buffer",
                            "ripgrep",
                            "path",
                        }
                    else
                        return {
                            "copilot",
                            "lsp",
                            "path",
                            "snippets",
                            "buffer",
                            "ripgrep",
                        }
                    end
                end,
                per_filetype = {
                    lua = { inherit_defaults = true, "lazydev" },
                    gitcommit = { "copilot", "buffer" },
                    markdown = {},
                    csv = { "buffer" },
                    codecompanion = { "codecompanion" },
                },
                providers = {
                    lsp = {
                        score_offset = 50,
                        min_keyword_length = 0,
                    },
                    snippets = {
                        score_offset = 10,
                        min_keyword_length = 2,
                    },
                    ripgrep = {
                        name = "RipGrep",
                        module = "blink-ripgrep",
                        score_offset = -100,
                        ---@module "blink-ripgrep"
                        ---@type blink-ripgrep.Options
                        opts = {},
                    },
                    copilot = {
                        name = "Copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        min_keyword_length = 0,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    cmdline = {
                        min_keyword_length = function(ctx)
                            -- when typing a command, only show when the keyword is 3 characters or longer
                            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                                return 3
                            end
                            return 0
                        end,
                    },
                },
            },
            cmdline = {
                keymap = {
                    ["<Tab>"] = { "accept" },
                    -- ["<CR>"] = { "accept_and_enter", "fallback" },
                },
                completion = {
                    menu = { auto_show = true },
                    ghost_text = { enabled = true },
                },
            },
        },
        opts_extend = { "sources.default" },
    },

    {
        "folke/sidekick.nvim",
        event = "VeryLazy",
        opts = {
            cli = {
                mux = {
                    backend = "tmux",
                    enabled = true,
                },
            },
        },
        keys = {
            {
                "<tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function()
                    require("sidekick.cli").focus()
                end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function()
                    require("sidekick.cli").toggle({ name = "copilot", focus = true })
                end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function()
                    require("sidekick.cli").select()
                end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function()
                    require("sidekick.cli").close()
                end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function()
                    require("sidekick.cli").send({ msg = "{this}" })
                end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function()
                    require("sidekick.cli").send({ msg = "{file}" })
                end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function()
                    require("sidekick.cli").send({ msg = "{selection}" })
                end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function()
                    require("sidekick.cli").prompt()
                end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function()
                    require("sidekick.cli").toggle({ name = "claude", focus = true })
                end,
                desc = "Sidekick Toggle Claude",
            },
        },
    },
}
