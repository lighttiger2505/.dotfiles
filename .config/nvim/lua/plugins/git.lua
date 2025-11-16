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
                    require("gitsigns").nav_hunk("next")
                end,
                mode = "n",
                desc = "GitSigns Jump next hunk",
            },
            {
                "[g",
                function()
                    require("gitsigns").nav_hunk("prev")
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
            require("diffview").setup()
        end,
        keys = {
            {
                "<Leader>dd",
                "<cmd>DiffviewOpen<CR>",
                mode = "n",
                desc = "Diffview Open diff view",
            },
            {
                "<Leader>dc",
                "<cmd>DiffviewClose<CR>",
                mode = "n",
                desc = "Diffview Close diff view",
            },
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
        "akinsho/toggleterm.nvim",
        event = "VeryLazy",
        version = "*",
        opts = {},
        -- TermExec direction=float cmd="tig status"
        keys = {
            {
                "<Leader>l",
                "<cmd>ToggleTerm direction=float<cr>",
                mode = { "n" },
                desc = "Toggleterm launch floating terminal",
            },
            {
                "<Leader>gg",
                "<cmd>1TermExec name='TigStatus' direction=float cmd='tig status; exit'<cr>",
                mode = { "n" },
                desc = "Toggleterm tig status",
            },
            {
                "<Leader>gp",
                "<cmd>2TermExec name='GitPush' direction=horizontal size=20 cmd='git push && exit'<cr>",
                mode = { "n" },
                desc = "Toggleterm git push",
            },
        },
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
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()
        end,
        opts = {
            blame_options = { "-w" },
            date_format = "%Y.%m.%d",
            mappings = {
                commit_info = "i",
                stack_push = "<TAB>",
                stack_pop = "<BS>",
                show_commit = "",
                close = { "<esc>", "q" },
            },
        },
        keys = {
            { "<Leader>gb", "<cmd>BlameToggle<cr>", mode = { "n" }, desc = "Git blame toggle" },
        },
    },
}
