return {
    {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "kkharji/sqlite.lua",
        },
        opts = {},
        keys = {
            { "<Space>p", "<Cmd>Telescope git_files<CR>",  mode = "n", desc = "find git files" },
            { "<Space>s", "<Cmd>Telescope git_status<CR>", mode = "n", desc = "find git status files" },
            { "<Space>b", "<Cmd>Telescope buffers<CR>",    mode = "n", desc = "find buffer" },
            { "<Space>r", "<Cmd>Telescope oldfiles<CR>",   mode = "n", desc = "find old files" },
            { "<Space>e", "<Cmd>Telescope live_grep<CR>",  mode = "n", desc = "find live grep" },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
        },
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
        end,
    },

}
