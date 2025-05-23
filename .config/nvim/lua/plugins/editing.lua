return {
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                surrounds = {
                    -- override non space pair
                    ["("] = {
                        add = function()
                            return { { "(" }, { ")" } }
                        end,
                    },
                    ["["] = {
                        add = function()
                            return { { "[" }, { "]" } }
                        end,
                    },
                    ["{"] = {
                        add = function()
                            return { { "{" }, { "}" } }
                        end,
                    },
                },
                keymaps = {
                    -- insert = "<C-g>s",
                    -- insert_line = "<C-g>S",
                    normal = "sa",
                    -- normal_cur = "yss",
                    -- normal_line = "yS",
                    -- normal_cur_line = "ySS",
                    visual = "sa",
                    -- visual_line = "gS",
                    delete = "sd",
                    change = "sr",
                    -- change_line = "cS",
                },
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
            })
            require("telescope").load_extension("yank_history")
        end,
        keys = {
            { "y", mode = "n" },
            { "Y", mode = "n" },
            { "p", mode = "n" },
            { "P", mode = "n" },
            {
                "<Space>y",
                "<Cmd>Telescope yank_history<CR>",
                mode = "n",
                desc = "Yanky Select yank history",
            },
        },
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
}
