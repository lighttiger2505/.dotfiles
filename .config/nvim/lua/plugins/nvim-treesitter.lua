require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "css",
        "dockerfile",
        "go",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = false
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
