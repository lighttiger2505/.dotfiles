return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            local ensureInstalled = {
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
            }
            local alreadyInstalled = require("nvim-treesitter.config").get_installed()
            local parsersToInstall = vim.iter(ensureInstalled)
                :filter(function(parser)
                    return not vim.tbl_contains(alreadyInstalled, parser)
                end)
                :totable()
            require("nvim-treesitter").install(parsersToInstall)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    -- Enable treesitter highlighting and disable regex syntax
                    pcall(vim.treesitter.start)
                    -- Enable treesitter-based indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
        config = function()
            require("nvim-treesitter").setup({
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
            })
        end,
    },
}
