return {
    {
        "prochri/telescope-all-recent.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "kkharji/sqlite.lua",
        },
        opts = {
            scoring = {
                boost_factor = 0.001
            },
            default = {
                sorting = 'recent'
            },
        },
        keys = {
            {
                "<Space>p",
                "<Cmd>lua require('telescope.telescope-config').project_files()<CR>",
                mode = "n",
                desc = "Telescope Find git files",
            },
            { "<Space>s", "<Cmd>Telescope git_status<CR>",             mode = "n", desc = "Telescope Find git status files" },
            { "<Space>b", "<Cmd>Telescope buffers<CR>",                mode = "n", desc = "Telescope Find buffer" },
            { "<Space>r", "<Cmd>Telescope oldfiles cwd_only=true<CR>", mode = "n", desc = "Telescope Find old files" },
            { "<Space>l", "<Cmd>Telescope live_grep<CR>",              mode = "n", desc = "Telescope Find live grep" },
            { "<Space>m", "<Cmd>Telescope marks<CR>",                  mode = "n", desc = "Telescope Find marks" },
            { "<Space>g", "<Cmd>Telescope grapple tags<CR>",           mode = "n", desc = "Telescope Find grapple tags" },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
            "cbochs/grapple.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                        prompt_position = "top",
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
            telescope.load_extension("grapple")
            telescope.load_extension("file_browser")
        end,
    },
}
