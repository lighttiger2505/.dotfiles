---@module "lazy"
---@type LazySpec
return {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
        "mikavilpas/blink-ripgrep.nvim",
        "giuxtaposition/blink-cmp-copilot",
        "rafamadriz/friendly-snippets",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = "enter" },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 50,
            },
            menu = {
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
                gitcommit = { "buffer" },
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
                    module = "blink-cmp-copilot",
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
}
