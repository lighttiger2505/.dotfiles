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
        end,
        keys = {
            { "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", mode = "n" },
            { "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", mode = "n" },
            { "*", "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>", mode = "v" },
            { "#", "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>", mode = "v" },
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
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or ""
                        return " " .. icon .. count
                    end,
                    groups = {
                        options = {
                            toggle_hidden_on_enter = true,
                        },
                        items = {
                            {
                                name = "Tests",
                                highlight = { underline = true, sp = "blue" },
                                priority = 2,
                                matcher = function(buf)
                                    return buf.name:match("%_test") or buf.name:match("%_spec")
                                end,
                            },
                            {
                                name = "Docs",
                                highlight = { undercurl = true, sp = "green" },
                                priority = 1,
                                matcher = function(buf)
                                    return buf.name:match("%.md") or buf.name:match("%.txt")
                                end,
                            },
                            {
                                name = "Conf",
                                highlight = { undercurl = true, sp = "yellow" },
                                priority = 1,
                                matcher = function(buf)
                                    return buf.name:match("%.yml") or buf.name:match("%.yaml")
                                end,
                            },
                        },
                    },
                },
            })
        end,
        keys = {
            { "<C-j>", "<Cmd>BufferLineCyclePrev<CR>", mode = "n", desc = "buffer prev" },
            { "<C-k>", "<Cmd>BufferLineCycleNext<CR>", mode = "n", desc = "buffer next" },
            { "<Space>j", "<Cmd>BufferLineSortByExtension<CR>", mode = "n", desc = "buffer sort by extension" },
            { "<Space>k", "<Cmd>BufferLineSortByDirectory<CR>", mode = "n", desc = "buffer sort by directory" },
        },
    },
}
