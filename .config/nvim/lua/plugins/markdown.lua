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
                    vim.keymap.set("n", "<Leader>bb", "<Plug>Markdown_FollowLink", bufopts)
                    vim.keymap.set("n", "O", "<Plug>Markdown_NewLineAbove", bufopts)
                    vim.keymap.set("n", "o", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("n", "<Tab>", "<Plug>Markdown_Fold", bufopts)
                    vim.keymap.set("i", "<Enter>", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("x", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("n", "<Enter>", "<Plug>Markdown_Checkbox", bufopts)
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
        'dhruvasagar/vim-table-mode',
        ft = { "markdown" },
        config = function()
            vim.g.loaded_table_mode = 1
            vim.g.table_mode_disable_mappings = 1
            vim.g.table_mode_disable_tableize_mappings = 1
        end,
    },

    {
        'MeanderingProgrammer/markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        ft = { "markdown" },
        name = 'render-markdown',
        config = function()
            require('render-markdown').setup({
                win_options = {
                    conceallevel = {
                        default = vim.api.nvim_get_option_value('conceallevel', {}),
                        rendered = 2,
                    },
                    concealcursor = {
                        default = vim.api.nvim_get_option_value('concealcursor', {}),
                        rendered = 'c',
                    },
                },
                table_style = 'normal',
            })
        end,
    },

    {
        "epwalsh/obsidian.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/vaults/personal",
                },
                {
                    name = "work",
                    path = "~/vaults/work",
                },
            },
        },
    },
}
