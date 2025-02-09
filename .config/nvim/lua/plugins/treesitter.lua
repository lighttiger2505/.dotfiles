return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "RRethy/nvim-treesitter-textsubjects" },
            { "nvim-treesitter/nvim-treesitter-context" }
        },
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
                sync_install = true,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                    disable = function(_, buf)
                        local max_filesize = 1000 * 1024 -- 1000 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                matchup = {
                    enable = true,
                    include_match_words = true,
                    enable_quotes = true,
                },
                textsubjects = {
                    enable = true,
                    prev_selection = "<BS>",
                    keymaps = {
                        ["."] = "textsubjects-smart",
                        ["<CR>"] = "textsubjects-container-outer",
                        ["i<CR>"] = "textsubjects-container-inner",
                    },
                },
            })

            require("treesitter-context").setup {
                enable = true,
            }
        end,
        build = ":TSUpdate",
    },
}
