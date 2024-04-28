return {
    {
        "machakann/vim-sandwich",
        config = function()
            local kmopt = { noremap = true, silent = true }
            vim.keymap.set("n", "s", "<Nop>", kmopt)
            vim.keymap.set("x", "s", "<Nop>", kmopt)
        end,
        keys = {
            { "s", mode = "n" },
            { "s", mode = "x" },
        },
    },

    {
        "Wansmer/treesj",
        keys = {
            { "<Leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 1500 },
    },

    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%H:%M"],
                    augend.date.alias["%Y年%-m月%-d日"],
                    augend.date.alias["%Y年%-m月%-d日(%ja)"],
                    augend.constant.alias.ja_weekday,
                    augend.constant.alias.ja_weekday_full,
                },
            })
        end,
        keys = {
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "normal")
                end,
                mode = "n",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "normal")
                end,
                mode = "n",
                desc = "dial decrement",
            },
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "visual")
                end,
                mode = "v",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "visual")
                end,
                mode = "v",
                desc = "dial decrement",
            },
        },
    },

    {
        "keaising/im-select.nvim",
        event = "InsertEnter",
        config = function()
            if vim.fn.has("macunix") == 1 then
                require("im_select").setup({
                    default_im_select = "com.apple.keylayout.US",
                    default_command = "im-select",
                    async_switch_im = false,
                })
            else
                require("im_select").setup({
                    default_im_select = "keyboard-us",
                    default_command = "fcitx5-remote",
                    async_switch_im = false,
                })
            end
        end,
    },

    {
        "gbprod/yanky.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("yanky").setup({
                ring = {
                    history_length = 100,
                    storage = "shada",
                    sync_with_numbered_registers = true,
                    cancel_event = "update",
                    ignore_registers = {},
                    update_register_on_cycle = false,
                },
                system_clipboard = {
                    sync_with_ring = true,
                },
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 300,
                },
            })
            require("telescope").load_extension("yank_history")
        end,
        keys = {
            { "y", mode = "n" },
            { "Y", mode = "n" },
            { "p", mode = "n" },
            { "P", mode = "n" },
            {
                "<Space>t",
                "<Cmd>Telescope yank_history<CR>",
                mode = "n",
                desc = "select yank history insert mode",
            },
        },
    },

    {
        "bloznelis/before.nvim",
        event = "VeryLazy",
        config = function()
            require('before').setup()
        end,
        keys = {
            { "<C-h>",      function() require('before').jump_to_last_edit() end,       mode = "n", desc = "jump to last edit" },
            { "<C-l>",      function() require('before').jump_to_next_edit() end,       mode = "n", desc = "jump to next edit" },
            { "<leader>oq", function() require('before').show_edits_in_quickfix() end,  mode = "n", desc = "show edits in quickfix" },
            { "<leader>oe", function() require('before').show_edits_in_telescope() end, mode = "n", desc = "show edits in telescope" },
        },
    },
}
