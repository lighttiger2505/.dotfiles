return {
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
        config = true, -- default settings
    },

    {
        "tyru/open-browser.vim",
        event = "VeryLazy",
        config = function()
            local kmopt = { noremap = true, silent = true }
            vim.keymap.set("n", "<Leader>bb", "<Plug>(openbrowser-smart-search)", kmopt)
            vim.keymap.set("x", "<Leader>bb", "<Plug>(openbrowser-smart-search)", kmopt)
        end,
    },
}
