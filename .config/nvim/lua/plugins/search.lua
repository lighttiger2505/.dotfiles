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
                    require("grug-far").open({ prefills = { filesFilter = "!*_test.go", flags = "--hidden" } })
                end,
                mode = { "n", "v" },
                desc = "GrugFar open grug far panel",
            },
        },
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "<Enter>",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
        },
    },
}
