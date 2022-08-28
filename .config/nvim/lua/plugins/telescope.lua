require('telescope').setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            width = 0.8,
            height = 0.80,
            prompt_position = 'top',
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
        }
    }
}
require('telescope').load_extension('fzf')
