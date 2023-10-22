require "nvim-treesitter.configs".setup {
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
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function (_, buf)
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
}
