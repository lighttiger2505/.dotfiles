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
            "copilotlsp-nvim/copilot-lsp",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
                ["<Tab>"] = {
                    function(cmp)
                        if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                            cmp.hide()
                            return (
                                require("copilot-lsp.nes").apply_pending_nes()
                                and require("copilot-lsp.nes").walk_cursor_end_edit()
                            )
                        end
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
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
        "copilotlsp-nvim/copilot-lsp",
        init = function()
            vim.g.copilot_nes_debounce = 500
            vim.keymap.set("n", "<tab>", function()
                local bufnr = vim.api.nvim_get_current_buf()
                local state = vim.b[bufnr].nes_state
                if state then
                    local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
                        or (
                            require("copilot-lsp.nes").apply_pending_nes()
                            and require("copilot-lsp.nes").walk_cursor_end_edit()
                        )
                    return nil
                else
                    return "<C-i>"
                end
            end, { desc = "Accept Copilot NES suggestion", expr = true })
        end,
    },
}
