return {
    {
        "dmmulroy/ts-error-translator.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function ()
            require("ts-error-translator").setup()
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function ()
            require("windwp/nvim-ts-autotag").setup({
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = false
                },
            })
        end,
    },
}
