return {
    {
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                config = function()
                    require("ts_context_commentstring").setup({
                        enable_autocmd = false,
                    })
                end,
            },
        },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
        keys = {
            { "gc", mode = "n" },
            { "gc", mode = "v" },
        },
    },

    {
        "mattn/sonictemplate-vim",
        cmd = { "Template" },
    },

    {
        "nanotee/sqls.nvim",
        ft = { "sql" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "mattn/vim-sqlfmt",
        ft = { "sql" },
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
            local kmopt = { noremap = true, silent = true }
            vim.keymap.set("n", "<leader>r", ":RunCode<CR>", kmopt)
            vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", kmopt)
            vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", kmopt)
            vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", kmopt)
            vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", kmopt)
            vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", kmopt)
            vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", kmopt)
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
            local kmopt = { noremap = true, silent = true }
            vim.keymap.set("n", "<LocalLeader>b", "<Cmd>GoBuild<CR>", kmopt)
            vim.keymap.set("n", "<LocalLeader>m", "<Cmd>GoImport<CR>", kmopt)
            vim.keymap.set("n", "<LocalLeader>a", "<Cmd>GoAlt<CR>", kmopt)
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
    },

    {
        "sheerun/vim-polyglot",
        event = "VeryLazy",
    },
}
