return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            {
                "nvimdev/lspsaga.nvim",
                config = function()
                    require("lspsaga").setup({
                        symbol_in_winbar = {
                            enable = false,
                        },
                        finder = {
                            keys = {
                                shuttle = "[w",
                                toggle_or_open = "<CR>",
                                vsplit = "v",
                                split = "s",
                                tabe = "t",
                                tabnew = "r",
                                quit = "q",
                                close = "<C-c>k",
                            },
                        },
                    })
                end
            },
            {
                "folke/neodev.nvim",
                ft = "lua",
            },
        },
        cond = function()
            -- ignore filetype markdown
            return vim.bo.filetype ~= "markdown"
        end,
        config = function()
            local nvim_lsp = require("lspconfig")
            local servers = {
                "gopls",
                "tsserver",
                "lua_ls",
                "sqls",
            }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup({
                    flags = {
                        debounce_text_changes = 150,
                    },
                })
            end

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local bufopts = { noremap = true, silent = true, buffer = ev.buf }
                    -- builtin lsp
                    vim.keymap.set("n", "<LocalLeader>n", vim.lsp.buf.references, bufopts)
                    vim.keymap.set("n", "<LocalLeader>R", vim.lsp.buf.rename, bufopts)
                    vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "<LocalLeader>e", vim.diagnostic.open_float, bufopts)
                    vim.keymap.set("n", "<LocalLeader>d", vim.diagnostic.setloclist, bufopts)
                    -- lsp saga
                    vim.keymap.set("n", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", bufopts)
                    vim.keymap.set("i", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", bufopts)
                    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
                    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
                    vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>", bufopts)
                    vim.keymap.set("n", "<LocalLeader>i", "<cmd>Lspsaga finder imp<CR>", bufopts)
                end,
            })

            nvim_lsp.gopls.setup({
                settings = {
                    gopls = {
                        ["Formatting.local"] = "github.com/MobilityTechnologies",
                    },
                },
            })

            nvim_lsp.sqls.setup({
                cmd = {
                    "sqls",
                    "-log",
                    os.getenv("HOME") .. "/sqls.log",
                    "-config",
                    os.getenv("HOME") .. "/.config/sqls/config.yml",
                },
                -- cmd = { 'sqls', '-config', os.getenv("HOME") .. '/.config/sqls/config.yml' },
                settings = {
                    sqls = {
                        connections = {
                            {
                                driver = "mysql",
                                dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
                            },
                            {
                                driver = "postgresql",
                                dataSourceName =
                                "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
                            },
                        },
                    },
                },
            })

            nvim_lsp.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "4",
                            },
                        },
                    },
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },

    {
        "j-hui/fidget.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        event = "LspAttach",
        config = function()
            require("fidget").setup()
        end,
    },

    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("aerial").setup({
                backends = { "lsp", "treesitter", "markdown" },
            })
            require("telescope").load_extension("aerial")
        end,
        keys = {
            { "]]",        "<cmd>AerialNext<CR>",       mode = "n", desc = "jump prev symbol" },
            { "[[",        "<cmd>AerialPrev<CR>",       mode = "n", desc = "jump next symbol" },
            { "<Leader>o", "<cmd>AerialToggle!<CR>",    mode = "n", desc = "open symbol list" },
            { "<Space>o",  "<Cmd>Telescope aerial<CR>", mode = "n", desc = "fuzzy search symbol list" },
        },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<LocalLeader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { { "prettier" } },
                typescript = { { "prettier" } },
                typescriptreact = { { "prettier" } },
                json = { { "jq" } },
                go = { "goimports", "gofmt" },
            },
            format_on_save = { timeout_ms = 300, lsp_fallback = true },
        },
    },

    {
        "dmmulroy/ts-error-translator.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function()
            require("ts-error-translator").setup()
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePost" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                -- lua = { "luacheck" },
                javascript = { "eslint" },
                typescript = { "eslint" },
                typescriptreact = { "eslint" },
                go = { "golangcilint" },
                json = { "jsonlint" },
                proto = { "buf_lint" },
                make = { "checkmake" },
                zsh = { "zsh" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },

    {
        "icholy/lsplinks.nvim",
        config = function()
            require("lsplinks").setup()
        end,
        keys = {
            { "gx", function() require("lsplinks").gx() end, mode = "n", desc = "jump lsp link" },
        },
    },
}
