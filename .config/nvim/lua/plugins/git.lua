return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup()
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            -- normarl mode
            {
                "]g",
                function()
                    require("gitsigns").next_hunk()
                end,
                mode = "n",
                desc = "GitSigns Jump next hunk",
            },
            {
                "[g",
                function()
                    require("gitsigns").prev_hunk()
                end,
                mode = "n",
                desc = "GitSigns Jump prev hunk",
            },
            {
                "<leader>hb",
                function()
                    require("gitsigns").blame_line({ full = true })
                end,
                mode = "n",
                desc = "GitSigns show blame",
            },
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk()
                end,
                mode = "n",
                desc = "GitSigns Stage hunk",
            },
            {
                "<leader>hu",
                function()
                    require("gitsigns").undo_stage_hunk()
                end,
                mode = "n",
                desc = "GitSigns Unstage hunk",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk()
                end,
                mode = "n",
                desc = "GitSigns Reset hunk",
            },
            -- visual mode
            {
                "<leader>hs",
                function()
                    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end,
                mode = "v",
                desc = "GitSigns Stage hunk",
            },
            {
                "<leader>hu",
                function()
                    require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end,
                mode = "v",
                desc = "GitSigns Unstage hunk",
            },
            {
                "<leader>hr",
                function()
                    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end,
                mode = "v",
                desc = "GitSigns Reset hunk",
            },
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
        config = function()
            local cb = require("diffview.config").diffview_callback
            require("diffview").setup({
                diff_binaries = false, -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                use_icons = true, -- Requires nvim-web-devicons
                icons = { -- Only applies when use_icons is true.
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = {
                    listing_style = "tree", -- One of 'list' or 'tree'
                    tree_options = { -- Only applies when listing_style is 'tree'
                        flatten_dirs = true, -- Flatten dirs that only contain one single dir
                        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
                    },
                },
                default_args = { -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                hooks = {}, -- See ':h diffview-config-hooks'
                key_bindings = {
                    disable_defaults = false, -- Disable the default key bindings
                    -- The `view` bindings are active in the diff buffers, only when the current
                    -- tabpage is a Diffview.
                    view = {
                        ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
                        ["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
                        ["gf"] = cb("goto_file"), -- Open the file in a new split in previous tabpage
                        ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
                        ["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
                        ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
                        ["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
                    },
                    file_panel = {
                        ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                        ["S"] = cb("stage_all"), -- Stage all entries.
                        ["U"] = cb("unstage_all"), -- Unstage all entries.
                        ["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
                        ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["gf"] = cb("goto_file"),
                        ["<C-w><C-f>"] = cb("goto_file_split"),
                        ["<C-w>gf"] = cb("goto_file_tab"),
                        ["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
                        ["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files"),
                    },
                    file_history_panel = {
                        ["g!"] = cb("options"), -- Open the option panel
                        ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
                        ["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
                        ["zR"] = cb("open_all_folds"),
                        ["zM"] = cb("close_all_folds"),
                        ["j"] = cb("next_entry"),
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"),
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"),
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["gf"] = cb("goto_file"),
                        ["<C-w><C-f>"] = cb("goto_file_split"),
                        ["<C-w>gf"] = cb("goto_file_tab"),
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files"),
                    },
                    option_panel = {
                        ["<tab>"] = cb("select"),
                        ["q"] = cb("close"),
                    },
                },
            })
        end,
        keys = {
            { "<Leader>dd", "<cmd>DiffviewOpen<CR>", mode = "n", desc = "Diffview Open diff view" },
            { "<Leader>dc", "<cmd>DiffviewClose<CR>", mode = "n", desc = "Diffview Close diff view" },
            {
                "<Leader>dh",
                "<cmd>DiffviewFileHistory<CR>",
                mode = "n",
                desc = "Diffview Open diff view for file history",
            },
            {
                "<Leader>df",
                "<cmd>DiffviewFileHistory %<CR>",
                mode = "n",
                desc = "Diffview Open diff view for current file history",
            },
        },
    },

    {
        "numToStr/FTerm.nvim",
        lazy = false,
        config = function()
            local fterm = require("FTerm")
            require("FTerm").setup({
                border = "double",
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            })
            local tig = fterm:new({
                ft = "fterm_tig",
                cmd = "tig status",
                dimensions = {
                    height = 0.9,
                    width = 0.9,
                },
            })
            vim.keymap.set("n", "<Leader>gg", function()
                tig:toggle()
            end)
        end,
    },

    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { "package.json", "go.mod", ".git" },
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            })
        end,
    },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
        lazy = false,
    },

    {
        "linrongbin16/gitlinker.nvim",
        cmd = "GitLink",
        opts = {},
        keys = {
            { "gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "GitLinker Yank git link" },
            { "gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "GitLinker Open git link" },
        },
    },

    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end,
        keys = {
            { "<Leader>gl", "<cmd>Octo pr list<cr>", mode = { "n", "v" }, desc = "Octo open pull request" },
            { "<Leader>gd", "<cmd>Octo pr diff<cr>", mode = { "n", "v" }, desc = "Octo show pull request diff" },
            {
                "<Leader>gr",
                "<cmd>Octo review start<cr>",
                mode = { "n", "v" },
                desc = "Octo start  pull request review",
            },
        },
    },
}
