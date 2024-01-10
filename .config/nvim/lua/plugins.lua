local map = vim.api.nvim_set_keymap
local kopts = { noremap = true, silent = true }
local mapopts = { noremap = false, silent = true }

return {
    -- colorschema
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function ()
            vim.cmd([[colorscheme nightfox]])
            vim.cmd([[hi VertSplit guifg=#928374]])
        end,
    },
    { "folke/tokyonight.nvim" },

    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function () require("plugins.lualine") end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        init = function ()
            map("n", "<Leader>t", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>f", "<cmd>Neotree reveal<CR>", kopts)
        end,
        config = function ()
            require("plugins.neo-tree")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

    -- tree-sitter
    {
        "nvim-treesitter/nvim-treesitter",
        config = function () require("plugins.nvim-treesitter") end,
        build = ":TSUpdate",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function () require("plugins.nvim-treesitter-textobjects") end,
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                config = function () require("plugins.nvim-ts-context-commentstring") end,
            },
            { "RRethy/nvim-treesitter-textsubjects" },
            { "RRethy/nvim-treesitter-endwise" },
        },
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function () require("plugins.Comment") end,
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        keys = {
            { "gc", mode = "n" },
            { "gc", mode = "v" },
        },
    },

    -- Indent
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function ()
            local ibl = require("ibl")
            ibl.setup()
            ibl.overwrite {
                exclude = {
                    filetypes = { "go" },
                }
            }
        end,
        main = "ibl",
        opts = {},
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        config = function ()
            require("gitsigns").setup()
            map("n", "]g", "<Cmd>Gitsigns next_hunk<CR>", kopts)
            map("n", "[g", "<Cmd>Gitsigns prev_hunk<CR>", kopts)
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
    },

    -- Search
    {
        "kevinhwang91/nvim-hlslens",
        init = function () require("plugins.hlslens") end,
        dependencies = {
            "haya14busa/vim-asterisk",
            init = function ()
                vim.cmd [[map *  <Plug>(asterisk-z*)]]
                vim.cmd [[map #  <Plug>(asterisk-z#)]]
                vim.cmd [[map g* <Plug>(asterisk-gz*)]]
                vim.cmd [[map g# <Plug>(asterisk-gz#)]]
            end,
        },
        keys = {
            { "*", mode = "n" },
            { "#", mode = "n" },
            { "*", mode = "v" },
            { "#", mode = "v" },
        },
    },

    -- Code diff view
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
        init = function ()
            map("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
        config = function () require("plugins.diffview") end,
    },

    -- Syntax
    {
        "sheerun/vim-polyglot",
        event = "VeryLazy",
    },

    -- Template
    {
        "mattn/sonictemplate-vim",
        cmd = { "Template" },
    },

    -- General language server
    {
        "nvimtools/none-ls.nvim",
        ft = {
            "javascript",
            "javascript.jsx",
            "javascriptreact",
            "typescript",
            "typescript.tsx",
            "typescriptreact",
            "go",
        },
        config = function ()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.golangci_lint,
                },
            })
        end,
    },

    -- Toggle terminal
    {
        "akinsho/toggleterm.nvim",
        config = function () require("plugins.toggleterm") end,
        keys = { "<Leader>g" },
    },

    -- SQL language server extension
    {
        "nanotee/sqls.nvim",
        ft = { "sql" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "mattn/vim-sqlfmt",
        ft = { "sql" },
    },

    -- LuaSnip
    {
        "benfowler/telescope-luasnip.nvim",
        config = function ()
            require("telescope").load_extension("luasnip")
        end,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "L3MON4D3/LuaSnip",
        },
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-path" },
            { "onsails/lspkind.nvim" },
            { "saadparwaiz1/cmp_luasnip" },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                event = "InsertEnter",
                config = function () require("plugins.LuaSnip") end,
                dependencies = {
                    "rafamadriz/friendly-snippets"
                },
            },
            { "zbirenbaum/copilot-cmp" },
        },
        config = function () require("plugins.nvim-cmp") end,
    },

    -- nvim-lsp
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
            { "williamboman/mason-lspconfig.nvim" },
            {
                "nvimdev/lspsaga.nvim",
                config = function ()
                    require("lspsaga").setup({
                        symbol_in_winbar = {
                            enable = false
                        }
                    })
                end,
                init = function ()
                    map("n", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", kopts)
                    map("i", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", kopts)
                    map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", kopts)
                    map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", kopts)
                end,
            },
        },
        cond = function ()
            -- ignore filetype markdown
            return vim.bo.filetype ~= "markdown"
        end,
        config = function () require("plugins.nvim-lsp") end,
    },
    {
        "j-hui/fidget.nvim",
        tag          = "legacy",
        dependencies = { "neovim/nvim-lspconfig" },
        event        = "LspAttach",
        config       = function () require("fidget").setup() end,
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        dependencies = { "neovim/nvim-lspconfig" },
        init = function ()
            map("n", "<Leader>o", ":SymbolsOutline<CR>", kopts)
        end,
        config = function () require("plugins.symbols-outline") end,
    },
    {
        "lewis6991/hover.nvim",
        config = function ()
            require("hover").setup {
                init = function ()
                    require "hover.providers.lsp"
                end,
            }
        end,
        init = function ()
            vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
            vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
        end,
        keys = { "K", "gK" }
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<LocalLeader>f",
                function ()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { { "prettierd", "prettier" } },
                typescript = { { "prettierd", "prettier" } },
                typescriptreact = { { "prettierd", "prettier" } },
                json = { { "prettierd", "prettier" } },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
        },
        init = function ()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },

    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            { "nvim-telescope/telescope-frecency.nvim" },
        },
        cmd = "Telescope",
        init = function ()
            map("n", "<C-j><C-p>", "<Cmd>Telescope git_files<CR>", kopts)
            map("n", "<C-j><C-s>", "<Cmd>Telescope git_status<CR>", kopts)
            map("n", "<C-j><C-b>", "<Cmd>Telescope buffers<CR>", kopts)
            map("n", "<C-j><C-]>", "<Cmd>Telescope lsp_workspace_symbols<CR>", kopts)
            map("n", "<C-j><C-o>", "<Cmd>Telescope lsp_document_symbols<CR>", kopts)
            map("n", "<C-j><C-r>", "<Cmd>Telescope frecency workspace=CWD<CR>", kopts)
            map("n", "<C-j><C-f>", "<Cmd>Telescope frecency<CR>", kopts)
        end,
        config = function () require("plugins.telescope") end,
    },

    {
        "CRAG666/code_runner.nvim",
        cmd = {
            "RunCode",
            "RunFile",
            "RunProject",
            "RunClose",
            "CRFiletype",
            "CRProjects",
        },
        init = function ()
            map("n", "<leader>r", ":RunCode<CR>", kopts)
            map("n", "<leader>rf", ":RunFile<CR>", kopts)
            map("n", "<leader>rft", ":RunFile tab<CR>", kopts)
            map("n", "<leader>rp", ":RunProject<CR>", kopts)
            map("n", "<leader>rc", ":RunClose<CR>", kopts)
            map("n", "<leader>crf", ":CRFiletype<CR>", kopts)
            map("n", "<leader>crp", ":CRProjects<CR>", kopts)
        end,
        config = function ()
            require("code_runner").setup({
                filetype = {
                    python = "python3 -u",
                    typescript = "deno run",
                    rust = {
                        "cd $dir &&",
                        "rustc $fileName &&",
                        "$dir/$fileNameWithoutExt"
                    },
                    go = {
                        "cd $dir &&",
                        "go run $fileName &&",
                    },
                },
            })
        end,
    },

    -- Translate sneak and camel
    {
        "nicwest/vim-camelsnek",
        cmd = {
            "Snek",
            "Camel",
            "CamelB",
            "Kebab",
            "Screm",
        },
    },

    -- Browser
    {
        "tyru/open-browser.vim",
        event = { "BufReadPre", "BufNewFile" },
        config = function ()
            map("n", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("x", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("n", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
            map("x", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
        end,
        dependencies = { "tyru/open-browser-github.vim" },
    },


    -- Markdown edit
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
    },
    {
        "mzlogin/vim-markdown-toc",
        ft = { "markdown" },
    },
    {
        "folke/zen-mode.nvim",
        cmd = { "ZenMode" },
        config = function () require("zen-mode").setup {} end
    },

    -- Text object extension
    {
        "machakann/vim-sandwich",
        config = function ()
            map("n", "s", "<Nop>", kopts)
            map("x", "s", "<Nop>", kopts)
        end,
        keys = {
            { "s", mode = "n" },
            { "s", mode = "x" },
        },
    },

    -- Highlight yank
    {
        "machakann/vim-highlightedyank",
        init = function ()
            vim.g.highlightedyank_highlight_duration = 200
        end,
        event = { "TextYankPost" },
    },

    -- Project management
    {
        "ahmedkhalf/project.nvim",
        config = function ()
            require("project_nvim").setup {
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn" },
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            }
        end,
        event = { "BufReadPost" },
    },

    -- Golang extensions
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function ()
            require("go").setup()
        end,
        init = function ()
            map("n", "<LocalLeader>b", "<Cmd>GoBuild<CR>", kopts)
            map("n", "<LocalLeader>m", "<Cmd>GoImport<CR>", kopts)
            map("n", "<LocalLeader>a", "<Cmd>GoAlt<CR>", kopts)
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "Wansmer/treesj",
        keys = {
            { "<Leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 1500 },
    },
    {
        "monaqa/dial.nvim",
        keys = {
            { "<C-a>", mode = "n" },
            { "<C-x>", mode = "n" },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
    },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
        event = "VeryLazy",
    },

    {
        "keaising/im-select.nvim",
        lazy = false,
        config = function ()
            if vim.fn.has("macunix") == 1 then
                require("im_select").setup({
                    default_im_select = "com.apple.keylayout.US",
                    default_command = "im-select",
                    async_switch_im = false
                })
            else
                require("im_select").setup({
                    default_im_select = "keyboard-us",
                    default_command = "fcitx5-remote",
                    async_switch_im = false
                })
            end
        end,
    },

    {
        "folke/neodev.nvim",
        ft = "lua"
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require("copilot").setup({})
        end,
    }

}
