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
                "<Leader>dr",
                "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>",
                mode = "n",
                desc = "Diffview Open for pull request review",
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

    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("neogit").setup()
        end,
        keys = {
            { "<Leader>gb", "<cmd>Neogit branch<cr>", mode = { "n", "v" }, desc = "Neogit branch checkout" },
            {
                "<Leader>gps",
                "<cmd>Neogit push<cr>",
                mode = { "n", "v" },
                desc = "Neogit push",
            },
            {
                "<Leader>gpl",
                "<cmd>Neogit pull<cr>",
                mode = { "n", "v" },
                desc = "Neogit pull",
            },
        },
    },
}
