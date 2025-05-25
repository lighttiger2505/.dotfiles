return {
    {
        "stevearc/overseer.nvim",
        cmd = { "Make", "Grep" },
        config = function()
            local overseer = require("overseer")
            overseer.setup({
                templates = { "builtin", "user.run_script" },
            })

            vim.api.nvim_create_user_command("OverseerRestartLast", function()
                local tasks = overseer.list_tasks({ recent_first = true })
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end, {})

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
    },

    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
        opts = {},
        keys = {
            {
                "<leader>rr",
                "<Cmd>CompilerOpen<CR>",
                mode = "n",
                desc = "Open compiler",
            },
            {
                "<leader>rs",
                "<Cmd>CompilerRedo<CR>",
                mode = "n",
                desc = "Redo last selected option",
            },
            {
                "<leader>rl",
                "<Cmd>CompilerToggleResults<CR>",
                mode = "n",
                desc = "Toggle compiler results",
            },
        },
    },
}
