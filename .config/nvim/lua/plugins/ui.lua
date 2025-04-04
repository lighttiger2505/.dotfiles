local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

return {
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mfussenegger/nvim-lint",
            "stevearc/overseer.nvim",
        },
        config = function ()
            local lint_progress = function ()
                local linters = require("lint").get_running()
                if #linters == 0 then
                    return ""
                end
                return "󱉶 "..table.concat(linters, ", ")
            end

            local overseer = require("overseer")
            local overseer_progress = {
                "overseer",
                label = "",     -- Prefix for task counts
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
                    lualine_a = {
                        "filename",
                        {
                            function ()
                                return require("grapple").name_or_index()
                            end,
                            cond = function ()
                                return package.loaded["grapple"] and require("grapple").exists()
                            end
                        }
                    },
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
        init = function ()
            map("n", "<Leader>t", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>f", "<cmd>Neotree reveal<CR>", kopts)
        end,
        config = function ()
            local launchTelescopeFiler = function (state)
                local node = state.tree:get_node()
                local dir = vim.fn.fnamemodify(node.path, ":h")
                require("telescope")
                local cmd = string.format("Telescope file_browser path=%s select_buffer=true", dir)
                vim.cmd(cmd)
            end
            require("neo-tree").setup({
                window = {
                    position = "float",
                    mappings = {
                        ["/"] = launchTelescopeFiler,
                        ["f"] = launchTelescopeFiler,
                    }
                },
                enable_diagnostics = false,
                enable_git_status = true,
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
        event = { "BufReadPre", "BufNewFile" },
        config = function ()
            require("hlchunk").setup({})
            local palette = require("nightfox.palette").load("nightfox")
            require("hlchunk.mods.chunk")({
                style = {
                    { fg = palette.blue.base },
                    { fg = palette.red.base },
                },
                line_num = {
                    enable = false,
                },
                duration = 0,
                delay = 0,
            }):enable()
            require("hlchunk.mods.indent")({}):enable()
            -- require('hlchunk.mods.line_num')({
            --     style = palette.red.base,
            -- }):enable()
        end
    },

    {
        "lukas-reineke/virt-column.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },

    {
        "kevinhwang91/nvim-hlslens",
        dependencies = {
            "haya14busa/vim-asterisk",
        },
        config = function ()
            require("hlslens").setup()
        end,
        keys = {
            { "*",  "<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>",  mode = { "n", "v" }, desc = "hlslens start" },
            { "#",  "<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>",  mode = { "n", "v" }, desc = "hlslens start" },
            { "g*", "<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>", mode = { "n", "v" }, desc = "hlslens start" },
            { "g#", "<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>", mode = { "n", "v" }, desc = "hlslens start" },
        },
    },

    -- QuickFix
    {
        "kevinhwang91/nvim-bqf",
        event = "FileType qf",
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {},
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
        },
        keys = {
            {
                "<leader>?",
                function ()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    {
        "romgrk/barbar.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function () vim.g.barbar_auto_setup = false end,
        opts = {
            animation = false,
        },
        keys = {
            { "<C-h>",    "<Cmd>BufferPrevious<CR>",         mode = "n", desc = "BarBar Move buffer prev" },
            { "<C-l>",    "<Cmd>BufferNext<CR>",             mode = "n", desc = "BarBar Move buffer next" },
            { "<Space>j", "<Cmd>BufferOrderByName<CR>",      mode = "n", desc = "BarBar Sort buffer by name" },
            { "<Space>k", "<Cmd>BufferOrderByDirectory<CR>", mode = "n", desc = "BarBar Sort buffer by directory" },
        },
    },

    {
        "kazhala/close-buffers.nvim",
        config = function ()
            require("close_buffers").setup({})
        end,
        keys = {
            { "<Space>a", function () require("close_buffers").delete({ type = "hidden", force = true }) end, mode = "n", desc = "CloseBuffers Close all non-visible buffers" },
            { "<Space>q", function () require("close_buffers").delete({ type = "this" }) end,                 mode = "n", desc = "CloseBuffers Close the current buffer" },
        },
    },

    {
        "shortcuts/no-neck-pain.nvim",
        cmd = "NoNeckPain",
        config = function ()
            require("no-neck-pain").setup({
                width = 144,
                autocmds = {
                    enableOnVimEnter = false,
                },
            })
        end,
        keys = {
            { "<Leader>w", "<Cmd>NoNeckPain<CR>", mode = "n", desc = "NoNeckPain" },
        },
    },


    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            stiffness = 0.7,
            trailing_stiffness = 0.4,
            distance_stop_animating = 0.5,
            smear_to_cmd = true,
        },
    },
}
