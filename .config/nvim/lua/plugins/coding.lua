local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

return {
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                ---Add a space b/w comment and the line
                ---@type boolean|fun():boolean
                padding = true,

                ---Whether the cursor should stay at its position
                ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
                ---@type boolean
                sticky = true,

                ---Lines to be ignored while comment/uncomment.
                ---Could be a regex string or a function that returns a regex string.
                ---Example: Use '^$' to ignore empty lines
                ---@type string|fun():string
                ignore = nil,

                ---LHS of toggle mappings in NORMAL + VISUAL mode
                ---@type table
                toggler = {
                    ---Line-comment toggle keymap
                    line = "gcc",
                    ---Block-comment toggle keymap
                    block = "gbc",
                },

                ---LHS of operator-pending mappings in NORMAL + VISUAL mode
                ---@type table
                opleader = {
                    ---Line-comment keymap
                    line = "gc",
                    ---Block-comment keymap
                    block = "gb",
                },

                ---LHS of extra mappings
                ---@type table
                extra = {
                    ---Add comment on the line above
                    above = "gcO",
                    ---Add comment on the line below
                    below = "gco",
                    ---Add comment at the end of line
                    eol = "gcA",
                },

                ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                ---NOTE: If `mappings = false` then the plugin won't create any mappings
                ---@type boolean|table
                mappings = {
                    ---Operator-pending mapping
                    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                    basic = true,
                    ---Extra mapping
                    ---Includes `gco`, `gcO`, `gcA`
                    extra = true,
                    ---Extended mapping
                    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                    extended = false,
                },

                ---Pre-hook, called before commenting the line
                ---@type fun(ctx: CommentCtx):string
                pre_hook = function(ctx)
                    -- Only calculate commentstring for tsx filetypes
                    if vim.bo.filetype == "typescriptreact" then
                        local U = require("Comment.utils")

                        -- Determine whether to use linewise or blockwise commentstring
                        local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.ctype == U.ctype.block then
                            location = require("ts_context_commentstring.utils").get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                            location = require("ts_context_commentstring.utils").get_visual_start_location()
                        end

                        return require("ts_context_commentstring.internal").calculate_commentstring({
                            key = type,
                            location = location,
                        })
                    end
                end,

                ---Post-hook, called after commenting is done
                ---@type fun(ctx: CommentCtx)
                post_hook = nil,
            })
        end,
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
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
            map("n", "<LocalLeader>b", "<Cmd>GoBuild<CR>", kopts)
            map("n", "<LocalLeader>m", "<Cmd>GoImport<CR>", kopts)
            map("n", "<LocalLeader>a", "<Cmd>GoAlt<CR>", kopts)
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },
}
