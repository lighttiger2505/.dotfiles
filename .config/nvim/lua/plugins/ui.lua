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
                    return "󰦕"
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
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "filename" },
                    lualine_c = { "diff", lint_progress, "diagnostics" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
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
                close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = false,
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1, -- extra padding on left hand side
                        -- indent guides
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        highlight = "NeoTreeIndentMarker",
                        -- expander config, needed for nesting files
                        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "ﰊ",
                        default = "*",
                    },
                    modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                    },
                    name = {
                        trailing_slash = false,
                        use_git_status_colors = true,
                    },
                    git_status = {
                        symbols = {
                            -- Change type
                            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                            deleted = "✖", -- this can only be used in the git_status source
                            renamed = "", -- this can only be used in the git_status source
                            -- Status type
                            untracked = "",
                            ignored = "",
                            unstaged = "",
                            staged = "",
                            conflict = "",
                        },
                    },
                },
                window = {
                    position = "left",
                    width = 40,
                    mapping_options = {
                        noremap = true,
                        nowait = true,
                    },
                    mappings = {
                        ["<space>"] = {
                            "toggle_node",
                            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
                        },
                        ["<2-LeftMouse>"] = "open",
                        ["<cr>"] = "open",
                        ["S"] = "open_split",
                        ["s"] = "open_vsplit",
                        ["t"] = "open_tabnew",
                        ["w"] = "open_with_window_picker",
                        ["C"] = "close_node",
                        ["a"] = "add",
                        ["A"] = "add_directory",
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["y"] = "copy_to_clipboard",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["c"] = "copy", -- takes text input for destination
                        ["m"] = "move", -- takes text input for destination
                        ["q"] = "close_window",
                        ["R"] = "refresh",
                    },
                },
                nesting_rules = {},
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_by_name = {
                            ".DS_Store",
                            "node_modules",
                        },
                        hide_by_pattern = { -- uses glob style patterns
                            --"*.meta"
                        },
                        never_show = { -- remains hidden even if visible is toggled to true
                            --".DS_Store",
                            --"thumbs.db"
                        },
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                    -- time the current file is changed while the tree is open.
                    hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                    -- in whatever position is specified in window.position
                    -- "open_current",  -- netrw disabled, opening a directory opens within the
                    -- window like netrw would, regardless of window.position
                    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                    use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                    -- instead of relying on nvim autocmd events.
                    window = {
                        mappings = {
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                            ["H"] = "toggle_hidden",
                            ["/"] = "fuzzy_finder",
                            ["f"] = "filter_on_submit",
                            ["<c-x>"] = "clear_filter",
                        },
                    },
                },
                buffers = {
                    show_unloaded = true,
                    window = {
                        mappings = {
                            ["bd"] = "buffer_delete",
                            ["<bs>"] = "navigate_up",
                            ["."] = "set_root",
                        },
                    },
                },
                git_status = {
                    window = {
                        position = "float",
                        mappings = {
                            ["A"] = "git_add_all",
                            ["gu"] = "git_unstage_file",
                            ["ga"] = "git_add_file",
                            ["gr"] = "git_revert_file",
                            ["gc"] = "git_commit",
                            ["gp"] = "git_push",
                            ["gg"] = "git_commit_and_push",
                        },
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
}
