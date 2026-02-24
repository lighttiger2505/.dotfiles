return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = false },
            picker = { enabled = false },
            notifier = { enabled = false },
            quickfile = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = false },
        },
        keys = {
            {
                "<Space>a",
                function()
                    Snacks.bufdelete.all(opts)
                end,
                mode = "n",
                desc = "Snacks delete all buffer",
            },
            {
                "<Space>q",
                function()
                    Snacks.bufdelete()
                end,
                mode = "n",
                desc = "Snacks delete current buffer",
            },
        },
    },
}
