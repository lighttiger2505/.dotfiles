local autocmd = vim.api.nvim_create_autocmd

return {
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "nvimdev/lspsaga.nvim" },
        },
        cond = function()
            -- ignore filetype markdown
            return vim.bo.filetype ~= "markdown"
        end,
        config = function()
            local group_name = "MyLspConfig"
            vim.api.nvim_create_augroup(group_name, { clear = true })

            -- Set diagnostics to location list
            autocmd({ "DiagnosticChanged" }, {
                group = group_name,
                pattern = "*",
                callback = function()
                    vim.diagnostic.setloclist({ open = false })
                end,
            })

            local nvim_lsp = require("lspconfig")
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = true,
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

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                -- builtin lsp
                vim.keymap.set("n", "<LocalLeader>n", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<LocalLeader>R", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<C-l>", vim.lsp.buf.signature_help, bufopts)
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
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- Enable underline, use default values
                    underline = true,
                    -- Enable virtual text, override spacing to 4
                    virtual_text = {
                        spacing = 4,
                    },
                    -- Use a function to dynamically turn signs off
                    -- and on, using buffer local variables
                    signs = function(namespace, bufnr)
                        return vim.b[bufnr].show_signs == true
                    end,
                    -- Disable a feature
                    update_in_insert = false,
                })

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            require("mason").setup()
            local servers = {
                "gopls",
                "rust_analyzer",
                "tsserver",
                "lua_ls",
                -- "solargraph",
                -- "rubocop",
                -- "ruby_ls",
                "sqls",
            }
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup({
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    },
                })
            end

            nvim_lsp.gopls.setup({
                on_attach = on_attach,
                settings = {
                    gopls = {
                        ["Formatting.local"] = "github.com/MobilityTechnologies",
                    },
                },
            })

            nvim_lsp.sqls.setup({
                on_attach = on_attach,
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
                                dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
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
            { "]]", "<cmd>AerialNext<CR>", mode = "n", desc = "jump prev symbol" },
            { "[[", "<cmd>AerialPrev<CR>", mode = "n", desc = "jump next symbol" },
            { "<Leader>o", "<cmd>AerialToggle!<CR>", mode = "n", desc = "open symbol list" },
            { "<C-j><C-o>", "<Cmd>Telescope aerial<CR>", mode = "n", desc = "fuzzy search symbol list" },
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
                json = { { "prettier" } },
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
        event = { "BufWritePre" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                javascript = { "eslint" },
                typescript = { "eslint" },
                typescriptreact = { "eslint" },
                go = { "golangcilint" },
                json = { "jsonlint" },
            }
            autocmd({ "BufWritePost" }, {
                callback = function()
                    local ns = lint.get_namespace("my_linter_name")
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.diagnostic.reset(ns, bufnr)
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
