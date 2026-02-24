return {
    {
        "kylechui/nvim-surround",
        version = "^4.0.0",
        event = "VeryLazy",
        config = function()
            vim.g.nvim_surround_no_normal_mappings = true
            vim.keymap.set("n", "sa", "<Plug>(nvim-surround-normal)", {
                desc = "Add a surrounding pair around a motion (normal mode)",
            })
            vim.keymap.set("n", "sd", "<Plug>(nvim-surround-delete)", {
                desc = "Delete a surrounding pair",
            })
            vim.keymap.set("n", "sr", "<Plug>(nvim-surround-change)", {
                desc = "Change a surrounding pair",
            })
        end,
    },

    {
        "Wansmer/treesj",
        keys = {
            { "<Leader>j", "<cmd>TSJToggle<cr>", desc = "treesj Toggle split join" },
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
                    default_im_select = "com.apple.keylayout.ABC",
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
        "hat0uma/csvview.nvim",
        ft = { "csv" },
        init = function()
            local group_name = "PluginNvimCsv"
            vim.api.nvim_create_augroup(group_name, { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group_name,
                pattern = { "csv" },
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "<Leader>c", "<Cmd>CsvViewToggle<CR>", bufopts)
                end,
            })
        end,
        config = function()
            require("csvview").setup()
        end,
    },

    {
        "cappyzawa/trim.nvim",
        cmd = {
            "Trim",
            "TrimToggle",
        },
        opts = {
            trim_on_write = false,
        },
    },
}
