local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-lint",
            "stevearc/overseer.nvim",
        },
        config = function()
            local lint_progress = function()
                local linters = require("lint").get_running()
                if #linters == 0 then
                    return ""
                end
                return "󱉶 " .. table.concat(linters, ", ")
            end

            local overseer = require("overseer")
            local overseer_progress = {
                "overseer",
                label = '',     -- Prefix for task counts
                colored = true, -- Color the task icons and counts
                symbols = {
                    [overseer.STATUS.FAILURE] = "F:",
                    [overseer.STATUS.CANCELED] = "C:",
                    [overseer.STATUS.SUCCESS] = "S:",
                    [overseer.STATUS.RUNNING] = "R:",
                },
                unique = false,     -- Unique-ify non-running task count by name
                name = nil,         -- List of task names to search for
                name_not = false,   -- When true, invert the name search
                status = nil,       -- List of task statuses to display
                status_not = false, -- When true, invert the status search
            }

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
                    lualine_c = { "diff", overseer_progress, lint_progress, "diagnostics" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = { "filename" },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {},
            })
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        cmd = "Neotree",
        init = function()
            map("n", "<Leader>t", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>f", "<cmd>Neotree reveal<CR>", kopts)
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
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
        config = function()
            local palette = require('nightfox.palette').load("nightfox")
            require("hlchunk").setup({
                chunk = {
                    style = {
                        { fg = palette.blue.base },
                        { fg = palette.red.base },
                    },
                },
                line_num = {
                    enable = false,
                },
            })
        end
    },

    {
        "kevinhwang91/nvim-hlslens",
        dependencies = {
            "haya14busa/vim-asterisk",
        },
        config = function()
            require("hlslens").setup()
        end,
        keys = {
            { "*",  "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>",  mode = { "n", "v" } },
            { "#",  "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>",  mode = { "n", "v" } },
            { "g*", "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>", mode = { "n", "v" } },
            { "g#", "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>", mode = { "n", "v" } },
        },
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            registers = true,
            triggers = {
                -- plugin mappgins
                "<Leader>",
                "<LocalLeader>",
                "<Space>",
                ",",
                -- default mappings
                "]",
                "[",
                "g",
                "y",
                -- register
                "<C-r>",
                '"',
            },
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

    {
        'romgrk/barbar.nvim',
        event = "VeryLazy",
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        keys = {
            { "<C-h>",    "<Cmd>BufferPrevious<CR>",         mode = "n", desc = "buffer prev" },
            { "<C-l>",    "<Cmd>BufferNext<CR>",             mode = "n", desc = "buffer next" },
            { "<Space>j", "<Cmd>BufferOrderByName<CR>",      mode = "n", desc = "buffer sort by name" },
            { "<Space>k", "<Cmd>BufferOrderByDirectory<CR>", mode = "n", desc = "buffer sort by directory" },
        },
    },

    {
        "kazhala/close-buffers.nvim",
        config = function()
            require('close_buffers').setup({})
        end,
        keys = {
            { "<Space>c", function() require('close_buffers').delete({ type = 'hidden', force = true }) end, mode = "n", desc = "Delete all non-visible buffers" },
            { "<Space>q", function() require('close_buffers').delete({ type = 'this' }) end,                 mode = "n", desc = "Delete the current buffer" },
        },
    },

    {
        "shortcuts/no-neck-pain.nvim",
        cmd = "NoNeckPain",
        config = function()
            require("no-neck-pain").setup({
                width = 144,
                autocmds = {
                    enableOnVimEnter = false,
                },
            })
        end,
        keys = {
            { "<Leader>n", "<Cmd>NoNeckPain<CR>", mode = "n", desc = "no neck pain" },
        },
    },

    {
        'Bekaboo/dropbar.nvim',
        event = "VeryLazy",
    }
}
