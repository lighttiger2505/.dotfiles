return {
    {
        "kevinhwang91/nvim-hlslens",
        dependencies = {
            "haya14busa/vim-asterisk",
        },
        config = function()
            require("hlslens").setup()
        end,
        keys = {
            {
                "*",
                "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>",
                mode = { "n", "v" },
                desc = "hlslens start",
            },
            {
                "#",
                "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>",
                mode = { "n", "v" },
                desc = "hlslens start",
            },
            {
                "g*",
                "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>",
                mode = { "n", "v" },
                desc = "hlslens start",
            },
            {
                "g#",
                "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>",
                mode = { "n", "v" },
                desc = "hlslens start",
            },
        },
    },

    {
        "MagicDuck/grug-far.nvim",
        config = function()
            require("grug-far").setup({})
        end,
        keys = {
            {
                "<Leader>s",
                function()
                    require("grug-far").open({ prefills = { filesFilter = "", flags = "--hidden" } })
                end,
                mode = { "n", "v" },
                desc = "GrugFar open grug far panel",
            },
        },
    },

    {
        "nacro90/numb.nvim",
        event = "VeryLazy",
        config = function()
            require("numb").setup()
        end,
    },
}
