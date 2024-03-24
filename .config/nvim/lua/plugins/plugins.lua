local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local kopts = { noremap = true, silent = true }
local mapopts = { noremap = false, silent = true }

return {
    -- Fuzzy Finder
    {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = {
                    { "nvim-lua/plenary.nvim" },
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        build = "make",
                    },
                },
                cmd = "Telescope",
                init = function()
                    map("n", "<C-j><C-p>", "<Cmd>Telescope git_files<CR>", kopts)
                    map("n", "<C-j><C-s>", "<Cmd>Telescope git_status<CR>", kopts)
                    map("n", "<C-j><C-b>", "<Cmd>Telescope buffers<CR>", kopts)
                    map("n", "<C-j><C-]>", "<Cmd>Telescope lsp_workspace_symbols<CR>", kopts)
                    map("n", "<C-j><C-r>", "<Cmd>Telescope oldfiles<CR>", kopts)
                    map("n", "<C-j><C-e>", "<Cmd>Telescope live_grep<CR>", kopts)
                end,
                config = function()
                    local telescope = require("telescope")
                    telescope.setup({
                        defaults = {
                            sorting_strategy = "ascending",
                            layout_config = {
                                width = 0.9,
                                height = 0.9,
                                prompt_position = "top",
                                horizontal = {
                                    mirror = false,
                                    prompt_position = "top",
                                    preview_cutoff = 120,
                                    preview_width = 0.5,
                                },
                                vertical = {
                                    mirror = false,
                                    prompt_position = "top",
                                    preview_cutoff = 120,
                                    preview_width = 0.5,
                                },
                            },
                            file_sorter = require("telescope.sorters").get_fuzzy_file,
                            file_ignore_patterns = { "node_modules/*" },
                            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                            path_display = { "truncate" },
                        },
                        extensions = {
                            fzf = {
                                fuzzy = true,
                                override_generic_sorter = true,
                                override_file_sorter = true,
                                case_mode = "smart_case",
                            },
                        },
                    })
                    telescope.load_extension("fzf")
                    -- telescope.load_extension("frecency")

                    require("telescope-all-recent").setup({
                        database = {
                            folder = vim.fn.stdpath("data"),
                            file = "telescope-all-recent.sqlite3",
                            max_timestamps = 10,
                        },
                        debug = false,
                        scoring = {
                            recency_modifier = { -- also see telescope-frecency for these settings
                                [1] = { age = 240, value = 100 }, -- past 4 hours
                                [2] = { age = 1440, value = 80 }, -- past day
                                [3] = { age = 4320, value = 60 }, -- past 3 days
                                [4] = { age = 10080, value = 40 }, -- past week
                                [5] = { age = 43200, value = 20 }, -- past month
                                [6] = { age = 129600, value = 10 }, -- past 90 days
                            },
                            -- how much the score of a recent item will be improved.
                            boost_factor = 0.0001,
                        },
                        default = {
                            disable = true, -- disable any unkown pickers (recommended)
                            use_cwd = true, -- differentiate scoring for each picker based on cwd
                            sorting = "recent", -- sorting: options: 'recent' and 'frecency'
                        },
                        pickers = { -- allows you to overwrite the default settings for each picker
                            man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
                                disable = false,
                                use_cwd = false,
                                sorting = "frecency",
                            },

                            -- change settings for a telescope extension.
                            -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
                            ["extension_name#extension_method"] = {
                                -- [...]
                            },
                        },
                    })
                end,
            },
            { "kkharji/sqlite.lua" },
            { "stevearc/dressing.nvim" },
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
                        "$dir/$fileNameWithoutExt",
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
            autocmd("FileType", {
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
        config = function()
            require("zen-mode").setup({})
        end,
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
            require("project_nvim").setup({
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn" },
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            })
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
            require("dial.config").augends:register_group({
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
            })
        end,
        keys = {
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "normal")
                end,
                mode = "n",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "normal")
                end,
                mode = "n",
                desc = "dial decrement",
            },
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "visual")
                end,
                mode = "v",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "visual")
                end,
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
                    async_switch_im = false,
                })
            else
                require("im_select").setup({
                    default_im_select = "keyboard-us",
                    default_command = "fcitx5-remote",
                    async_switch_im = false,
                })
            end
        end,
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
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
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {},
    },

    {
        "gbprod/yanky.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("yanky").setup({
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 300,
                },
            })
            require("telescope").load_extension("yank_history")
            map("n", "<Leader>p", "<Cmd>Telescope yank_history<CR>", kopts)
        end,
        keys = {
            {
                "<Leader p>",
                "<Cmd>Telescope yank_history<CR>",
                mode = "n",
                desc = "select yank history normal mode",
            },
            {
                "<C-r>",
                "<Cmd>Telescope yank_history<CR>",
                mode = "i",
                desc = "select yank history insert mode",
            },
        },
    },

    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            local helpers = require("incline.helpers")
            local devicons = require("nvim-web-devicons")
            require("incline").setup({
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
                            or "",
                        " ",
                        { filename, gui = modified and "bold,italic" or "bold" },
                        " ",
                        guibg = "#44406e",
                    }
                end,
            })
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

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            window = {
                border = "single",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 1, 2, 1, 2 },
                winblend = 0,
                zindex = 1000,
            },
        },
    },
}
