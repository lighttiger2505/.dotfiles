---@module "lazy"
---@type LazySpec
return {
    "saghen/blink.cmp",
    dependencies = {
        "mikavilpas/blink-ripgrep.nvim",
        "giuxtaposition/blink-cmp-copilot",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        sources = {
            keymap = { preset = "default" },
            default = {
                "copilot",
                "lsp",
                "path",
                "snippets",
                "buffer",
                "ripgrep",
            },
            completion = { documentation = { auto_show = true } },
            providers = {
                ripgrep = {
                    module = "blink-ripgrep",
                    name = "Ripgrep",
                    ---@module "blink-ripgrep"
                    ---@type blink-ripgrep.Options
                    opts = {},
                    transform_items = function(_, items)
                        for _, item in ipairs(items) do
                            item.labelDetails = {
                                description = "(rg)",
                            }
                        end
                        return items
                    end,
                },
                copilot = {
                    name = "copilot",
                    module = "blink-cmp-copilot",
                    score_offset = 100,
                    async = true,
                    transform_items = function(_, items)
                        for _, item in ipairs(items) do
                            item.kind_icon = ""
                            item.labelDetails = {
                                description = "(copilot)",
                            }
                        end
                        return items
                    end,
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        opts_extend = { "sources.default" },
    },
}
