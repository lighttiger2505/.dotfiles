require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "css",
        "dockerfile",
        "go",
        -- "javascript",
        "lua",
        "make",
        -- "scala",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    highlight = {
        enable = true,
        disable = { "typescript" },
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
}
