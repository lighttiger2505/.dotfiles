return {
    {
        "folke/sidekick.nvim",
        event = "VeryLazy",
        opts = {
            cli = {
                win = {
                    split = {
                        width = 0.5,
                    },
                },
                mux = {
                    backend = "tmux",
                    enabled = true,
                },
            },
        },
        keys = {
            {
                "<Tab>",
                function()
                    -- if there is a next edit, jump to it, otherwise apply it if any
                    if not require("sidekick").nes_jump_or_apply() then
                        return "<Tab>" -- fallback to normal tab
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<S-Tab>",
                function()
                    require("sidekick").clear()
                end,
                expr = true,
                desc = "Clear Next Edit Suggestion",
            },
            {
                "<c-.>",
                function()
                    require("sidekick.cli").focus()
                end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function()
                    require("sidekick.cli").toggle({ name = "copilot", focus = true })
                end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function()
                    require("sidekick.cli").select()
                end,
                -- Or to select only installed tools:
                -- require("sidekick.cli").select({ filter = { installed = true } })
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function()
                    require("sidekick.cli").close()
                end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function()
                    require("sidekick.cli").send({ msg = "{this}" })
                end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function()
                    require("sidekick.cli").send({ msg = "{file}" })
                end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function()
                    require("sidekick.cli").send({ msg = "{selection}" })
                end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function()
                    require("sidekick.cli").prompt()
                end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
            -- Example of a keybinding to open Claude directly
            {
                "<leader>ac",
                function()
                    require("sidekick.cli").toggle({ name = "claude", focus = true })
                end,
                desc = "Sidekick Toggle Claude",
            },
            -- Assumes `git commit` opened the COMMIT_EDITMSG buffer (filetype=gitcommit) in this Neovim
            {
                "<leader>ag",
                function()
                    if vim.bo.filetype ~= "gitcommit" then
                        vim.notify("Not a gitcommit buffer", vim.log.levels.WARN)
                        return
                    end
                    require("sidekick.cli").send({
                        msg = "{file} は git commit のメッセージ編集用バッファです。"
                            .. "git diff --staged の内容を確認し、Conventional Commits形式で"
                            .. "簡潔なコミットメッセージを作成して、このファイルの本文として書き込んでください"
                            .. "（#で始まるコメント行はそのまま残してください）。"
                            .. "書き方に迷ったら git log -n 20 で直近のコミットメッセージの傾向を参考にしてください。"
                            .. "git commit や git add の実行はせず、メッセージを記入するだけにとどめてください。",
                    })
                end,
                desc = "Sidekick Write Commit Message",
            },
        },
    },
}
