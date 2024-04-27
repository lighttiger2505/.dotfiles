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
            vim.keymap.set("n", "<LocalLeader>m", "<Cmd>GoImports<CR>", kmopt)
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

    {
        'stevearc/overseer.nvim',
        cmd = { "Make", "Grep" },
        config = function()
            local overseer = require("overseer")
            overseer.setup({
                templates = { "builtin", "user.run_script" },
            })

            -- Create async make command
            vim.api.nvim_create_user_command("Make", function(params)
                local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
                if num_subs == 0 then
                    cmd = cmd .. " " .. params.args
                end
                local task = overseer.new_task({
                    cmd = vim.fn.expandcmd(cmd),
                    components = {
                        { "on_output_quickfix", open = not params.bang, open_height = 8 },
                        "default",
                    },
                })
                task:start()
            end, {
                desc = "Run your makeprg as an Overseer task",
                nargs = "*",
                bang = true,
            })

            -- Create async grep command
            vim.api.nvim_create_user_command("Grep", function(params)
                -- Insert args at the '$*' in the grepprg
                local cmd, num_subs = vim.o.grepprg:gsub("%$%*", params.args)
                if num_subs == 0 then
                    cmd = cmd .. " " .. params.args
                end
                local task = overseer.new_task({
                    cmd = vim.fn.expandcmd(cmd),
                    components = {
                        {
                            "on_output_quickfix",
                            errorformat = vim.o.grepformat,
                            open = not params.bang,
                            open_height = 8,
                            items_only = true,
                        },
                        -- We don't care to keep this around as long as most tasks
                        { "on_complete_dispose", timeout = 30 },
                        "default",
                    },
                })
                task:start()
            end, { nargs = "*", bang = true, complete = "file" })
        end,
        keys = {
            { "<leader>r", "<Cmd>OverseerQuickAction<CR>", mode = "n", desc = "Overseer quick action" },
        },
    }
}
