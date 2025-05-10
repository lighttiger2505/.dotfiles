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
}
