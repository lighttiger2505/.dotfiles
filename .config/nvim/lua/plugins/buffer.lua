return {
    {
        "romgrk/barbar.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        opts = {
            animation = false,
        },
        keys = {
            { "<C-h>", "<Cmd>BufferPrevious<CR>", mode = "n", desc = "BarBar Move buffer prev" },
            { "<C-l>", "<Cmd>BufferNext<CR>", mode = "n", desc = "BarBar Move buffer next" },
            { "<Space>j", "<Cmd>BufferOrderByName<CR>", mode = "n", desc = "BarBar Sort buffer by name" },
            { "<Space>k", "<Cmd>BufferOrderByDirectory<CR>", mode = "n", desc = "BarBar Sort buffer by directory" },
        },
    },

    {
        "kazhala/close-buffers.nvim",
        config = function()
            require("close_buffers").setup({})
        end,
        keys = {
            {
                "<Space>a",
                function()
                    require("close_buffers").delete({ type = "hidden", force = true })
                end,
                mode = "n",
                desc = "CloseBuffers Close all non-visible buffers",
            },
            {
                "<Space>q",
                function()
                    require("close_buffers").delete({ type = "this" })
                end,
                mode = "n",
                desc = "CloseBuffers Close the current buffer",
            },
        },
    },
}
