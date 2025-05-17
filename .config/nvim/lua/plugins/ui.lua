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
                label = "", -- Prefix for task counts
                colored = true, -- Color the task icons and counts
                symbols = {
                    [overseer.STATUS.FAILURE] = "F:",
                    [overseer.STATUS.CANCELED] = "C:",
                    [overseer.STATUS.SUCCESS] = "S:",
                    [overseer.STATUS.RUNNING] = "R:",
                },
                unique = false, -- Unique-ify non-running task count by name
                name = nil, -- List of task names to search for
                name_not = false, -- When true, invert the name search
                status = nil, -- List of task statuses to display
                status_not = false, -- When true, invert the status search
            }

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
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
                            function()
                                return require("grapple").name_or_index()
                            end,
                            cond = function()
                                return package.loaded["grapple"] and require("grapple").exists()
                            end,
                        },
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
        init = function()
            map("n", "<Leader>t", "<cmd>Neotree toggle<CR>", kopts)
            map("n", "<Leader>f", "<cmd>Neotree reveal<CR>", kopts)
        end,
        config = function()
            require("telescope").load_extension("file_browser")
            local launchTelescopeFiler = function(state)
                local node = state.tree:get_node()
                local dir = vim.fn.fnamemodify(node.path, ":h")
                require("telescope").extensions.file_browser.file_browser({
                    path = dir,
                    hide_parent_dir = true,
                    select_buffer = true,
                    hidden = true,
                })
            end

            require("neo-tree").setup({
                window = {
                    position = "float",
                    mappings = {
                        ["/"] = launchTelescopeFiler,
                        ["f"] = launchTelescopeFiler,
                    },
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
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = { "nvim-telescope/telescope.nvim" },
            },
        },
    },

    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
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
        end,
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
            preset = "helix",
            win = {
                width = { min = 30, max = 60 },
                height = { min = 4, max = 0.75 },
                padding = { 0, 1 },
                col = 1,
                row = -1,
                border = "rounded",
                title = true,
                title_pos = "left",
            },
            layout = {
                width = { min = 30 },
            },
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
            { "<Leader>w", "<Cmd>NoNeckPain<CR>", mode = "n", desc = "NoNeckPain" },
        },
    },
}
-- hogehoge
