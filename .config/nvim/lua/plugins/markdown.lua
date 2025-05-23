return {
    {
        "ixru/nvim-markdown",
        ft = { "markdown" },
        init = function()
            local group_name = "PluginNvimMarkdown"
            vim.api.nvim_create_augroup(group_name, { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group_name,
                pattern = { "markdown" },
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "]]", "<Plug>Markdown_MoveToNextHeader", bufopts)
                    vim.keymap.set("n", "[[", "<Plug>Markdown_MoveToPreviousHeader", bufopts)
                    vim.keymap.set("n", "O", "<Plug>Markdown_NewLineAbove", bufopts)
                    vim.keymap.set("n", "o", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("n", "<Tab>", "<Plug>Markdown_Fold", bufopts)
                    vim.keymap.set("i", "<Enter>", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("x", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("n", "<Leader>c", "<Plug>Markdown_Checkbox", bufopts)
                end,
            })
        end,
        config = function()
            vim.g.vim_markdown_no_default_key_mappings = 1
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_toc_autofit = 1
        end,
    },

    {
        "Kicamon/markdown-table-mode.nvim",
        ft = { "markdown" },
        config = function()
            require("markdown-table-mode").setup({
                filetype = {
                    "*.md",
                },
                options = {
                    insert = true,
                    insert_leave = true,
                    pad_separator_line = false,
                    alig_style = "default",
                },
            })
        end,
    },

    {
        "MeanderingProgrammer/markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        -- ft = { "markdown" },
        event = "VeryLazy",
        name = "render-markdown",
        config = function()
            require("render-markdown").setup({
                win_options = {
                    conceallevel = {
                        default = vim.o.conceallevel,
                        rendered = 2,
                    },
                    concealcursor = {
                        default = vim.o.concealcursor,
                        rendered = "c",
                    },
                },
                table_style = "normal",
                code = {
                    position = "left",
                    style = "full",
                    border = "thick",
                    width = "block",
                    min_width = 45,
                    left_pad = 0,
                    language_pad = 2,
                },
                pipe_table = {
                    style = "normal",
                },
            })
        end,
    },

    {
        "epwalsh/obsidian.nvim",
        cmd = {
            "ObsidianNew",
            "ObsidianToday",
            "ObsidianQuickSwitch",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            ui = {
                enable = false,
            },
            workspaces = {
                {
                    name = "LiteratureNotes",
                    path = "~/vaults/00-Literature-Notes",
                },
                {
                    name = "FleetingNotes",
                    path = "~/vaults/01-Fleeting-Notes",
                },
                {
                    name = "PermanentNotes",
                    path = "~/vaults/02-Permanent-Notes",
                },
                {
                    name = "StructuredNotes",
                    path = "~/vaults/03-Structured-Notes",
                },
            },
            mappings = {},
        },
        keys = {
            { "<Space>v", "<Cmd>ObsidianQuickSwitch<CR>", mode = "n", desc = "Obsidian Quick Switch" },
        },
    },

    {
        "previm/previm",
        cmd = {
            "PrevimOpen",
        },
    },
}
