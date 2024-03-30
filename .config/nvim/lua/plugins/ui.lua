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
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
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
        dependencies = {
            "haya14busa/vim-asterisk",
        },
        config = function()
            require("hlslens").setup()
            vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], kopts)
        end,
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
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            triggers = {
                "<Leader>",
                "<Space>",
                ",",
                "]",
                "[",
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
        'akinsho/bufferline.nvim',
        event = "VeryLazy",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup({
                options = {
                    groups = {
                        options = {
                            toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
                        },
                        -- items = {
                        --     {
                        --         name = "Tests", -- Mandatory
                        --         highlight = { underline = true, sp = "blue" }, -- Optional
                        --         priority = 2, -- determines where it will appear relative to other groups (Optional)
                        --         icon = "", -- Optional
                        --         matcher = function(buf) -- Mandatory
                        --             return buf.filename:match('%_test') or buf.filename:match('%_spec')
                        --         end,
                        --     },
                        --     {
                        --         name = "Docs",
                        --         highlight = { undercurl = true, sp = "green" },
                        --         auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
                        --         -- matcher = function(buf)
                        --         --     return buf.filename:match('%.md') or buf.filename:match('%.txt')
                        --         -- end,
                        --         separator = { -- Optional
                        --             style = require('bufferline.groups').separator.tab
                        --         },
                        --     }
                        -- }
                    }
                },
            })
        end,
        keys = {
            { "<C-j>",    "<Cmd>BufferLineCyclePrev<CR>",       mode = "n", desc = "buffer prev" },
            { "<C-k>",    "<Cmd>BufferLineCycleNext<CR>",       mode = "n", desc = "buffer next" },
            { "<Space>j", "<Cmd>BufferLineSortByExtension<CR>", mode = "n", desc = "buffer sort by extension" },
            { "<Space>k", "<Cmd>BufferLineSortByDirectory<CR>", mode = "n", desc = "buffer sort by directory" },
        },
    },
    -- {
    --     "romgrk/barbar.nvim",
    --     version = "^1.0.0",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "lewis6991/gitsigns.nvim",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    --     init = function()
    --         vim.g.barbar_auto_setup = false
    --     end,
    --     opts = {},
    --     keys = {
    --         { "<C-j>",    "<Cmd>BufferPrevious<CR>",         mode = "n", desc = "change prev buffer" },
    --         { "<C-k>",    "<Cmd>BufferNext<CR>",             mode = "n", desc = "change next buffer" },
    --         { "<Space>q", "<Cmd>BufferClose<CR>",            mode = "n", desc = "buffer close" },
    --         { "<Space>j", "<Cmd>BufferPick<CR>",             mode = "n", desc = "sort buffer by directroy" },
    --         { "<Space>k", "<Cmd>BufferOrderByDirectory<CR>", mode = "n", desc = "sort buffer by directroy" },
    --     },
    -- },
}
