return {
    -- Browser
    {
        "tyru/open-browser.vim",
        event = "VeryLazy",
        config = function()
            local kmopt = { noremap = true, silent = true }
            vim.keymap.set("n", "<Leader>bb", "<Plug>(openbrowser-smart-search)", kmopt)
            vim.keymap.set("x", "<Leader>bb", "<Plug>(openbrowser-smart-search)", kmopt)
            vim.keymap.set("n", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
            vim.keymap.set("x", "<Leader>bh", ":OpenGithubFile<CR>", kopts)
        end,
        dependencies = { "tyru/open-browser-github.vim" },
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
    },
}
