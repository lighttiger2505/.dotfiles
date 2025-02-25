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

    -- {
    --     "luckasRanarison/tailwind-tools.nvim",
    --     ft = {
    --         "typescript",
    --         "typescript.tsx",
    --         "typescriptreact",
    --     },
    --     name = "tailwind-tools",
    --     build = ":UpdateRemotePlugins",
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     opts = {}
    -- },
}
