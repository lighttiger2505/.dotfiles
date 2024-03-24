local map = vim.keymap.set
local kopts = { noremap = true, silent = true }

return {
    {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                dependencies = {
                    { "nvim-lua/plenary.nvim" },
                    {
                        "nvim-telescope/telescope-fzf-native.nvim",
                        build = "make",
                    },
                },
                cmd = "Telescope",
                init = function()
                    map("n", "<Leader>fp", "<Cmd>Telescope git_files<CR>", kopts)
                    map("n", "<Leader>fs", "<Cmd>Telescope git_status<CR>", kopts)
                    map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", kopts)
                    map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", kopts)
                    map("n", "<Leader>fe", "<Cmd>Telescope live_grep<CR>", kopts)
                end,
                config = function()
                    local telescope = require("telescope")
                    telescope.setup({
                        defaults = {
                            sorting_strategy = "ascending",
                            layout_config = {
                                width = 0.9,
                                height = 0.9,
                                prompt_position = "top",
                                horizontal = {
                                    mirror = false,
                                    prompt_position = "top",
                                    preview_cutoff = 120,
                                    preview_width = 0.5,
                                },
                                vertical = {
                                    mirror = false,
                                    prompt_position = "top",
                                    preview_cutoff = 120,
                                    preview_width = 0.5,
                                },
                            },
                            file_sorter = require("telescope.sorters").get_fuzzy_file,
                            file_ignore_patterns = { "node_modules/*" },
                            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                            path_display = { "truncate" },
                        },
                        extensions = {
                            fzf = {
                                fuzzy = true,
                                override_generic_sorter = true,
                                override_file_sorter = true,
                                case_mode = "smart_case",
                            },
                        },
                    })
                    telescope.load_extension("fzf")
                    -- telescope.load_extension("frecency")

                    require("telescope-all-recent").setup({
                        database = {
                            folder = vim.fn.stdpath("data"),
                            file = "telescope-all-recent.sqlite3",
                            max_timestamps = 10,
                        },
                        debug = false,
                        scoring = {
                            recency_modifier = { -- also see telescope-frecency for these settings
                                [1] = { age = 240, value = 100 }, -- past 4 hours
                                [2] = { age = 1440, value = 80 }, -- past day
                                [3] = { age = 4320, value = 60 }, -- past 3 days
                                [4] = { age = 10080, value = 40 }, -- past week
                                [5] = { age = 43200, value = 20 }, -- past month
                                [6] = { age = 129600, value = 10 }, -- past 90 days
                            },
                            -- how much the score of a recent item will be improved.
                            boost_factor = 0.0001,
                        },
                        default = {
                            disable = true, -- disable any unkown pickers (recommended)
                            use_cwd = true, -- differentiate scoring for each picker based on cwd
                            sorting = "recent", -- sorting: options: 'recent' and 'frecency'
                        },
                        pickers = { -- allows you to overwrite the default settings for each picker
                            man_pages = { -- enable man_pages picker. Disable cwd and use frecency sorting.
                                disable = false,
                                use_cwd = false,
                                sorting = "frecency",
                            },

                            -- change settings for a telescope extension.
                            -- To find out about extensions, you can use `print(vim.inspect(require'telescope'.extensions))`
                            ["extension_name#extension_method"] = {
                                -- [...]
                            },
                        },
                    })
                end,
            },
            { "kkharji/sqlite.lua" },
            { "stevearc/dressing.nvim" },
        },
    },
}
