return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "fredrikaverpil/neotest-golang",
            "marilari88/neotest-vitest",
            "stevearc/overseer.nvim",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-golang"),
                },
                consumers = {
                    overseer = require("neotest.consumers.overseer"),
                },
                overseer = {
                    enabled = true,
                    force_default = false,
                },
            })
        end,
        keys = {
            {
                "<Leader>ee",
                function()
                    require("neotest").run.run()
                end,
                desc = "NeoTest Run the nearest test",
            },
            {
                "<Leader>ec",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "NeoTest Run the current file",
            },
            {
                "<Leader>ef",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "NeoTest Open test output to the floating window",
            },
            {
                "<Leader>eo",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "NeoTest Open test summary panel",
            },
            {
                "<Leader>ep",
                function()
                    require("neotest").output_panel.toggle()
                end,
                desc = "NeoTest Open test output panel",
            },
            {
                "<Leader>ew",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                desc = "NeoTest Watch the current file test",
            },
        },
    },
}
