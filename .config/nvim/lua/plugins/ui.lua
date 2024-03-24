local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local kopts = { noremap = true, silent = true }

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-lint",
        },
        config = function()
            local lint_progress = function()
                local linters = require("lint").get_running()
                if #linters == 0 then
                    return ""
                end
                return "󱉶 " .. table.concat(linters, ", ")
            end

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "nightfox",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    -- globalstatus = true,
                },
                sections = {
                    lualine_a = { "filename" },
                    lualine_b = { "branch" },
                    lualine_c = { "diff", lint_progress, "diagnostics" },
                    lualine_x = {},
                    lualine_y = { "encoding", "fileformat", "filetype" },
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {
                    lualine_a = { "buffers" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "tabs" },
                },
                extensions = {},
            })
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        init = function()
            map("n", "<Leader>tt", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>tf", "<cmd>Neotree reveal<CR>", kopts)
        end,
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_by_name = {
                            ".DS_Store",
                            "node_modules",
                        },
                    },
                    follow_current_file = {
                        enabled = false,
                    },
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        config = function()
            local ibl = require("ibl")
            ibl.setup()
            ibl.overwrite({
                exclude = {
                    filetypes = { "go" },
                },
            })
        end,
        main = "ibl",
        opts = {},
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({
                build_position_cb = function(plist, _, _, _)
                    require("scrollbar.handlers.search").handler.show(plist.start_pos)
                end,
            })
            local group_name = "ScrollbarSearchHide"
            augroup(group_name, { clear = true })
            autocmd("CmdlineLeave", {
                group = group_name,
                callback = function()
                    require("scrollbar.handlers.search").handler.hide()
                end,
            })
        end,
        dependencies = {
            "haya14busa/vim-asterisk",
            init = function()
                vim.cmd([[map *  <Plug>(asterisk-z*)]])
                vim.cmd([[map #  <Plug>(asterisk-z#)]])
                vim.cmd([[map g* <Plug>(asterisk-gz*)]])
                vim.cmd([[map g# <Plug>(asterisk-gz#)]])
            end,
        },
        keys = {
            { "*", mode = "n" },
            { "#", mode = "n" },
            { "*", mode = "v" },
            { "#", mode = "v" },
        },
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            "lewis6991/gitsigns.nvim",
            "folke/tokyonight.nvim",
        },
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                excluded_buftypes = {
                    "terminal",
                },
                excluded_filetypes = {
                    "cmp_docs",
                    "cmp_menu",
                    "prompt",
                    "TelescopePrompt",
                    "neo-tree",
                },
                show_in_active_only = true,
                handle = {
                    color = "#928374",
                },
                marks = {
                    Cursor = {
                        text = "■",
                        color = colors.blue,
                    },
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
            })
            require("scrollbar.handlers.search").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            window = {
                border = "single",
                position = "bottom",
                margin = { 1, 0, 1, 0 },
                padding = { 1, 2, 1, 2 },
                winblend = 0,
                zindex = 1000,
            },
        },
    },
}
