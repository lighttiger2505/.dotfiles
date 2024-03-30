local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function() require("gitsigns").setup() end,
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            -- normarl mode
            { "]g",         function() require("gitsigns").next_hunk() end,                                             mode = "n", desc = "next hunk" },
            { "[g",         function() require("gitsigns").prev_hunk() end,                                             mode = "n", desc = "prev hunk" },
            { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end,                             mode = "n", desc = "show blame" },
            { "<leader>hs", function() require("gitsigns").stage_hunk() end,                                            mode = "n", desc = "stage hunk" },
            { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end,                                       mode = "n", desc = "unstage hunk" },
            { "<leader>hr", function() require("gitsigns").reset_hunk() end,                                            mode = "n", desc = "reset hunk" },
            -- visual mode
            { "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,      mode = "v", desc = "stage hunk" },
            { "<leader>hu", function() require("gitsigns").undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v", desc = "unstage hunk" },
            { "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,      mode = "v", desc = "reset hunk" },
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
        init = function()
            map("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
        config = function()
            local cb = require("diffview.config").diffview_callback
            require("diffview").setup({
                diff_binaries = false,    -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                use_icons = true,         -- Requires nvim-web-devicons
                icons = {                 -- Only applies when use_icons is true.
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = {
                    listing_style = "tree",              -- One of 'list' or 'tree'
                    tree_options = {                     -- Only applies when listing_style is 'tree'
                        flatten_dirs = true,             -- Flatten dirs that only contain one single dir
                        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
                    },
                },
                default_args = { -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                hooks = {},                   -- See ':h diffview-config-hooks'
                key_bindings = {
                    disable_defaults = false, -- Disable the default key bindings
                    -- The `view` bindings are active in the diff buffers, only when the current
                    -- tabpage is a Diffview.
                    view = {
                        ["<tab>"] = cb("select_next_entry"),    -- Open the diff for the next file
                        ["<s-tab>"] = cb("select_prev_entry"),  -- Open the diff for the previous file
                        ["gf"] = cb("goto_file"),               -- Open the file in a new split in previous tabpage
                        ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
                        ["<C-w>gf"] = cb("goto_file_tab"),      -- Open the file in a new tabpage
                        ["<leader>e"] = cb("focus_files"),      -- Bring focus to the files panel
                        ["<leader>b"] = cb("toggle_files"),     -- Toggle the files panel.
                    },
                    file_panel = {
                        ["j"] = cb("next_entry"),      -- Bring the cursor to the next file entry
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"),      -- Bring the cursor to the previous file entry.
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                        ["S"] = cb("stage_all"),          -- Stage all entries.
                        ["U"] = cb("unstage_all"),        -- Unstage all entries.
                        ["X"] = cb("restore_entry"),      -- Restore entry to the state on the left side.
                        ["R"] = cb("refresh_files"),      -- Update stats and entries in the file list.
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["gf"] = cb("goto_file"),
                        ["<C-w><C-f>"] = cb("goto_file_split"),
                        ["<C-w>gf"] = cb("goto_file_tab"),
                        ["i"] = cb("listing_style"),       -- Toggle between 'list' and 'tree' views
                        ["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files"),
                    },
                    file_history_panel = {
                        ["g!"] = cb("options"),               -- Open the option panel
                        ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
                        ["y"] = cb("copy_hash"),              -- Copy the commit hash of the entry under the cursor
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

            local kopts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            local toggleterm = require("toggleterm")

            toggleterm.setup({
                shade_terminals = true,
            })

            local Terminal = require("toggleterm.terminal").Terminal
            local tig = Terminal:new({
                cmd = "tig status",
                dir = "git_dir",
                direction = "float",
                float_opts = {
                    border = "double",
                },
                -- function to run on opening the terminal
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                -- function to run on closing the terminal
                on_close = function(term)
                    vim.cmd("Closing terminal")
                end,
            })

            function _tigToggle()
                tig:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _tigToggle()<CR>", { noremap = true, silent = true })
        end,
        keys = { "<Leader>g" },
    },

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

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
        event = "VeryLazy",
    },
}
