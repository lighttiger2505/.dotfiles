return {
    {
        "dmmulroy/ts-error-translator.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function()
            require("ts-error-translator").setup()
        end,
    },

    {
        "dmmulroy/tsc.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function()
            require("tsc").setup({})
        end,
    },

    {
        "pmizio/typescript-tools.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },
}
