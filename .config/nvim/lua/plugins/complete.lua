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
                markdown = { "buffer" },
                csv = { "buffer" },
                codecompanion = { "codecompanion" },
            },
            providers = {
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {},
                },
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },
        cmdline = {
            keymap = {
                ["<Tab>"] = { "show", "accept" },
            },
            completion = { menu = { auto_show = true } },
        },
    },
    opts_extend = { "sources.default" },
}
