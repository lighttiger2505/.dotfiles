require "nvim-treesitter.configs".setup {
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
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]]"] = "@block.outer",
                ["]f"] = "@function.outer",
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_previous_start = {
                ["[f"] = "@block.outer",
                ["[s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next = {
                ["]c"] = "@conditional.outer",
            },
            goto_previous = {
                ["[c"] = "@conditional.outer",
            }
        },
    },
}
