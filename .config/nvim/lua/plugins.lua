local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local kopts = { noremap = true, silent = true }
local mapopts = { noremap = false, silent = true }

return {
    -- colorschema
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme nightfox]])
            vim.cmd([[highlight WinSeparator guifg=#928374]])
        end,
    },
    { "folke/tokyonight.nvim",    lazy = true, priority = 1000, },
    { "ellisonleao/gruvbox.nvim", lazy = true, priority = 1000, config = true },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-lint",
        },
        config = function() require("plugins.lualine") end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        init = function()
            map("n", "<Leader>t", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>f", "<cmd>Neotree reveal<CR>", kopts)
        end,
        config = function()
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
        config = function() require("plugins.nvim-treesitter") end,
        build = ":TSUpdate",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function() require("plugins.nvim-treesitter-textobjects") end,
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                ft = {
                    "typescript",
                    "typescript.tsx",
                    "typescriptreact",
                },
                config = function() require("plugins.nvim-ts-context-commentstring") end,

            },
            { "RRethy/nvim-treesitter-textsubjects" },
            { "RRethy/nvim-treesitter-endwise" },
        },
    },

    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function() require("plugins.Comment") end,
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
        event = "VeryLazy",
        config = function()
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
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup()
            map("n", "]g", "<Cmd>Gitsigns next_hunk<CR>", kopts)
            map("n", "[g", "<Cmd>Gitsigns prev_hunk<CR>", kopts)
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Search
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({
                build_position_cb = function(plist, _, _, _)
                    require("scrollbar.handlers.search").handler.show(plist.start_pos)
                end,
            })
            local group_name = "ScrollbarSearchHide"
            augroup(group_name, { clear = true })
            autocmd('CmdlineLeave', {
                group = group_name,
                callback = function()
                    require('scrollbar.handlers.search').handler.hide()
                end,
            })
        end,
        dependencies = {
            "haya14busa/vim-asterisk",
            init = function()
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
        init = function()
            map("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
        config = function() require("plugins.diffview") end,
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

    -- lint
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

    -- Toggle terminal
    {
        "akinsho/toggleterm.nvim",
        config = function() require("plugins.toggleterm") end,
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
                config = function() require("plugins.LuaSnip") end,
                dependencies = {
                    "rafamadriz/friendly-snippets"
                },
            },
            { "zbirenbaum/copilot-cmp" },
        },
        config = function() require("plugins.nvim-cmp") end,
    },

    -- nvim-lsp
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
        config = function() require("plugins.nvim-lsp") end,
    },
    {
        "j-hui/fidget.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        event        = "LspAttach",
        config       = function() require("fidget").setup() end,
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        dependencies = { "neovim/nvim-lspconfig" },
        init = function()
            map("n", "<Leader>o", ":SymbolsOutline<CR>", kopts)
        end,
        config = function() require("plugins.symbols-outline") end,
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
        config = function() require("ts-error-translator").setup() end,
    },

    -- Fuzzy Finder
    {
        'prochri/telescope-all-recent.nvim',
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = {
                    { "nvim-lua/plenary.nvim" },
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        build = "make",
                    },
                    -- { "nvim-telescope/telescope-frecency.nvim" },
                },
                cmd = "Telescope",
                init = function()
                    map("n", "<C-j><C-p>", "<Cmd>Telescope git_files<CR>", kopts)
                    map("n", "<C-j><C-s>", "<Cmd>Telescope git_status<CR>", kopts)
                    map("n", "<C-j><C-b>", "<Cmd>Telescope buffers<CR>", kopts)
                    map("n", "<C-j><C-]>", "<Cmd>Telescope lsp_workspace_symbols<CR>", kopts)
                    map("n", "<C-j><C-o>", "<Cmd>Telescope lsp_document_symbols<CR>", kopts)
                    map("n", "<C-j><C-r>", "<Cmd>Telescope oldfiles<CR>", kopts)
                    map("n", "<C-j><C-e>", "<Cmd>Telescope live_grep<CR>", kopts)
                end,
                config = function() require("plugins.telescope") end,
            },
            { "kkharji/sqlite.lua" },
            { "stevearc/dressing.nvim" }
        },
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
        init = function()
            map("n", "<leader>r", ":RunCode<CR>", kopts)
            map("n", "<leader>rf", ":RunFile<CR>", kopts)
            map("n", "<leader>rft", ":RunFile tab<CR>", kopts)
            map("n", "<leader>rp", ":RunProject<CR>", kopts)
            map("n", "<leader>rc", ":RunClose<CR>", kopts)
            map("n", "<leader>crf", ":CRFiletype<CR>", kopts)
            map("n", "<leader>crp", ":CRProjects<CR>", kopts)
        end,
        config = function()
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
        event = "VeryLazy",
        config = function()
            map("n", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("x", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("n", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
            map("x", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
        end,
        dependencies = { "tyru/open-browser-github.vim" },
    },


    -- Markdown edit
    {
        "ixru/nvim-markdown",
        ft = { "markdown" },
        init = function()
            local group_name = "PluginNvimMarkdown"
            augroup(group_name, { clear = true })
            autocmd('FileType', {
                group = group_name,
                pattern = { "markdown" },
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "]]", "<Plug>Markdown_MoveToNextHeader", bufopts)
                    vim.keymap.set("n", "[[", "<Plug>Markdown_MoveToPreviousHeader", bufopts)
                    vim.keymap.set("n", "<C-k>", "<Plug>Markdown_FollowLink", bufopts)
                    vim.keymap.set("n", "O", "<Plug>Markdown_NewLineAbove", bufopts)
                    vim.keymap.set("n", "o", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<Enter>", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("x", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                end,
            })
        end,
        config = function()
            vim.g.vim_markdown_no_default_key_mappings = 1
        end,
    },
    {
        "mattn/vim-maketable",
        cmd = { "MakeTable" },
    },
    {
        "folke/zen-mode.nvim",
        cmd = { "ZenMode" },
        config = function() require("zen-mode").setup {} end
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = { "markdown" },
        config = true,
    },

    -- Text object extension
    {
        "machakann/vim-sandwich",
        config = function()
            map("n", "s", "<Nop>", kopts)
            map("x", "s", "<Nop>", kopts)
        end,
        keys = {
            { "s", mode = "n" },
            { "s", mode = "x" },
        },
    },

    -- Project management
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup {
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn" },
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            }
        end,
    },

    -- Golang extensions
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        init = function()
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
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%H:%M"],
                    augend.date.alias["%Y年%-m月%-d日"],
                    augend.date.alias["%Y年%-m月%-d日(%ja)"],
                    augend.constant.alias.ja_weekday_full,
                },
            }
        end,
        keys = {
            {
                "<C-a>",
                function() require("dial.map").manipulate("increment", "normal") end,
                mode = "n",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function() require("dial.map").manipulate("decrement", "normal") end,
                mode = "n",
                desc = "dial decrement",
            },
            {
                "<C-a>",
                function() require("dial.map").manipulate("increment", "visual") end,
                mode = "v",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function() require("dial.map").manipulate("decrement", "visual") end,
                mode = "v",
                desc = "dial decrement",
            },
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
        config = function()
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
        config = function()
            require("copilot").setup({})
        end,
    },

    {
        "gbprod/yanky.nvim",
        event = "VeryLazy",
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 100,
                    storage = "shada",
                    sync_with_numbered_registers = true,
                    cancel_event = "update",
                    ignore_registers = { "_" },
                    update_register_on_cycle = false,
                },
                system_clipboard = {
                    sync_with_ring = true,
                },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 300,
                },
            })
        end,
    },

    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            local helpers = require 'incline.helpers'
            local devicons = require 'nvim-web-devicons'
            require('incline').setup {
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if filename == '' then
                        filename = '[No Name]'
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or
                        '',
                        ' ',
                        { filename, gui = modified and 'bold,italic' or 'bold' },
                        ' ',
                        guibg = '#44406e',
                    }
                end,
            }
        end,
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-go",
            "marilari88/neotest-vitest",
        },
        config = function()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-go"),
                },
            })
        end,
        keys = {
            {
                "<Leader>ss",
                function()
                    require("neotest").run.run()
                end,
                mode = "n",
                desc = "Run the nearest test",
            },
            {
                "<Leader>sc",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                mode = "n",
                desc = "Run the current file",
            },
            {
                "<Leader>sf",
                function()
                    require("neotest").summary.toggle()
                end,
                mode = "n",
                desc = "Open test output to the floating window",
            },
            {
                "<Leader>so",
                function()
                    require("neotest").summary.toggle()
                end,
                mode = "n",
                desc = "Open test summary panel",
            },
            {
                "<Leader>sp",
                function()
                    require("neotest").output_panel.toggle()
                end,
                mode = "n",
                desc = "Open test output panel",
            },
            {
                "<Leader>sw",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                mode = "n",
                desc = "Watch the current file test",
            },


        },
    },

    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            require("scrollbar").setup()
            require("scrollbar.handlers.search").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}
