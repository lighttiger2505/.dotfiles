return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "css",
                    "dockerfile",
                    "go",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                textsubjects = {
                    enable = true,
                    lookahead = true,
                    max_file_lines = 5000,
                    prev_selection = ",",
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        ["i;"] = "textsubjects-container-inner",
                    },
                },
                endwise = {
                    enable = true,
                },
                matchup = {
                    enable = true,
                    include_match_words = true,
                    enable_quotes = true,
                },
            })
        end,
        build = ":TSUpdate",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    require("nvim-treesitter.configs").setup({
                        textobjects = {
                            swap = {
                                enable = true,
                                swap_next = {
                                    ["<leader>a"] = "@parameter.inner",
                                },
                                swap_previous = {
                                    ["<leader>A"] = "@parameter.inner",
                                },
                            },
                            select = {
                                enable = true,
                                lookahead = true,
                                keymaps = {
                                    ["af"] = "@function.outer",
                                    ["if"] = "@function.inner",
                                    ["ac"] = "@class.outer",
                                    ["ic"] = "@class.inner",
                                },
                            },
                        },
                    })
                end,
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                ft = {
                    "typescript",
                    "typescript.tsx",
                    "typescriptreact",
                },
                config = function()
                    vim.g.skip_ts_context_commentstring_module = true
                    require("ts_context_commentstring").setup({
                        enable_autocmd = false,
                    })
                end,
            },
            { "RRethy/nvim-treesitter-textsubjects" },
            { "RRethy/nvim-treesitter-endwise" },
        },
    },
}
