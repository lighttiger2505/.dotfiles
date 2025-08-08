return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        -- config = function()
        --     vim.cmd([[colorscheme nightfox]])
        --     vim.cmd([[highlight WinSeparator guifg=#928374]])
        -- end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                custom_highlights = function(colors)
                    return {
                        WinSeparator = { fg = colors.overlay2 },
                    }
                end,
            })
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },
}
