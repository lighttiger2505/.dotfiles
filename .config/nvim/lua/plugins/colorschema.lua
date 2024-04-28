return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme nightfox]])
            vim.cmd([[highlight WinSeparator guifg=#928374]])
        end,
    },
    {
        "folke/tokyonight.nvim",
    },
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "rebelot/kanagawa.nvim",
    },
}
