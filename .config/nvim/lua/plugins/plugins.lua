local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local kopts = { noremap = true, silent = true }
local mapopts = { noremap = false, silent = true }

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

    -- Comment
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                ---Add a space b/w comment and the line
                ---@type boolean|fun():boolean
                padding = true,

                ---Whether the cursor should stay at its position
                ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
                ---@type boolean
                sticky = true,

                ---Lines to be ignored while comment/uncomment.
                ---Could be a regex string or a function that returns a regex string.
                ---Example: Use '^$' to ignore empty lines
                ---@type string|fun():string
                ignore = nil,

                ---LHS of toggle mappings in NORMAL + VISUAL mode
                ---@type table
                toggler = {
                    ---Line-comment toggle keymap
                    line = "gcc",
                    ---Block-comment toggle keymap
                    block = "gbc",
                },

                ---LHS of operator-pending mappings in NORMAL + VISUAL mode
                ---@type table
                opleader = {
                    ---Line-comment keymap
                    line = "gc",
                    ---Block-comment keymap
                    block = "gb",
                },

                ---LHS of extra mappings
                ---@type table
                extra = {
                    ---Add comment on the line above
                    above = "gcO",
                    ---Add comment on the line below
                    below = "gco",
                    ---Add comment at the end of line
                    eol = "gcA",
                },

                ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                ---NOTE: If `mappings = false` then the plugin won't create any mappings
                ---@type boolean|table
                mappings = {
                    ---Operator-pending mapping
                    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                    basic = true,
                    ---Extra mapping
                    ---Includes `gco`, `gcO`, `gcA`
                    extra = true,
                    ---Extended mapping
                    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                    extended = false,
                },

                ---Pre-hook, called before commenting the line
                ---@type fun(ctx: CommentCtx):string
                pre_hook = function(ctx)
                    -- Only calculate commentstring for tsx filetypes
                    if vim.bo.filetype == "typescriptreact" then
                        local U = require("Comment.utils")

                        -- Determine whether to use linewise or blockwise commentstring
                        local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

                        -- Determine the location where to calculate commentstring from
                        local location = nil
                        if ctx.ctype == U.ctype.block then
                            location = require("ts_context_commentstring.utils").get_cursor_location()
                        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                            location = require("ts_context_commentstring.utils").get_visual_start_location()
                        end

                        return require("ts_context_commentstring.internal").calculate_commentstring({
                            key = type,
                            location = location,
                        })
                    end
                end,

                ---Post-hook, called after commenting is done
                ---@type fun(ctx: CommentCtx)
                post_hook = nil,
            })
        end,
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        keys = {
            { "gc", mode = "n" },
            { "gc", mode = "v" },
        },
    },

    -- Indent
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

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup()
            local gs = package.loaded.gitsigns
            map("n", "]g", gs.next_hunk)
            map("n", "[g", gs.prev_hunk)
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end)
            map("n", "<leader>hs", gs.stage_hunk)
            map("n", "<leader>hu", gs.undo_stage_hunk)
            map("n", "<leader>hr", gs.reset_hunk)
            map("v", "<leader>hs", function()
                gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
            map("v", "<leader>hu", function()
                gs.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
            map("v", "<leader>hr", function()
                gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
            end)
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Search
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

    -- Code diff view
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
        init = function()
            map("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
        config = function()
            local cb = require("diffview.config").diffview_callback
            require("diffview").setup({
                diff_binaries = false, -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                use_icons = true, -- Requires nvim-web-devicons
                icons = { -- Only applies when use_icons is true.
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                },
                file_panel = {
                    listing_style = "tree", -- One of 'list' or 'tree'
                    tree_options = { -- Only applies when listing_style is 'tree'
                        flatten_dirs = true, -- Flatten dirs that only contain one single dir
                        folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
                    },
                },
                default_args = { -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {},
                },
                hooks = {}, -- See ':h diffview-config-hooks'
                key_bindings = {
                    disable_defaults = false, -- Disable the default key bindings
                    -- The `view` bindings are active in the diff buffers, only when the current
                    -- tabpage is a Diffview.
                    view = {
                        ["<tab>"] = cb("select_next_entry"), -- Open the diff for the next file
                        ["<s-tab>"] = cb("select_prev_entry"), -- Open the diff for the previous file
                        ["gf"] = cb("goto_file"), -- Open the file in a new split in previous tabpage
                        ["<C-w><C-f>"] = cb("goto_file_split"), -- Open the file in a new split
                        ["<C-w>gf"] = cb("goto_file_tab"), -- Open the file in a new tabpage
                        ["<leader>e"] = cb("focus_files"), -- Bring focus to the files panel
                        ["<leader>b"] = cb("toggle_files"), -- Toggle the files panel.
                    },
                    file_panel = {
                        ["j"] = cb("next_entry"), -- Bring the cursor to the next file entry
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"), -- Bring the cursor to the previous file entry.
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"), -- Open the diff for the selected entry.
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["-"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                        ["S"] = cb("stage_all"), -- Stage all entries.
                        ["U"] = cb("unstage_all"), -- Unstage all entries.
                        ["X"] = cb("restore_entry"), -- Restore entry to the state on the left side.
                        ["R"] = cb("refresh_files"), -- Update stats and entries in the file list.
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["gf"] = cb("goto_file"),
                        ["<C-w><C-f>"] = cb("goto_file_split"),
                        ["<C-w>gf"] = cb("goto_file_tab"),
                        ["i"] = cb("listing_style"), -- Toggle between 'list' and 'tree' views
                        ["f"] = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files"),
                    },
                    file_history_panel = {
                        ["g!"] = cb("options"), -- Open the option panel
                        ["<C-A-d>"] = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
                        ["y"] = cb("copy_hash"), -- Copy the commit hash of the entry under the cursor
                        ["zR"] = cb("open_all_folds"),
                        ["zM"] = cb("close_all_folds"),
                        ["j"] = cb("next_entry"),
                        ["<down>"] = cb("next_entry"),
                        ["k"] = cb("prev_entry"),
                        ["<up>"] = cb("prev_entry"),
                        ["<cr>"] = cb("select_entry"),
                        ["o"] = cb("select_entry"),
                        ["<2-LeftMouse>"] = cb("select_entry"),
                        ["<tab>"] = cb("select_next_entry"),
                        ["<s-tab>"] = cb("select_prev_entry"),
                        ["gf"] = cb("goto_file"),
                        ["<C-w><C-f>"] = cb("goto_file_split"),
                        ["<C-w>gf"] = cb("goto_file_tab"),
                        ["<leader>e"] = cb("focus_files"),
                        ["<leader>b"] = cb("toggle_files"),
                    },
                    option_panel = {
                        ["<tab>"] = cb("select"),
                        ["q"] = cb("close"),
                    },
                },
            })

            local kopts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>d", ":DiffviewOpen<CR>", kopts)
        end,
    },

    -- Syntax
    {
        "sheerun/vim-polyglot",
        event = "VeryLazy",
    },

    -- Template
    {
        "mattn/sonictemplate-vim",
        cmd = { "Template" },
    },

    -- lint
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePre" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                javascript = { "eslint" },
                typescript = { "eslint" },
                typescriptreact = { "eslint" },
                go = { "golangcilint" },
                json = { "jsonlint" },
            }
            autocmd({ "BufWritePost" }, {
                callback = function()
                    local ns = lint.get_namespace("my_linter_name")
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.diagnostic.reset(ns, bufnr)
                    require("lint").try_lint()
                end,
            })
        end,
    },

    -- Toggle terminal
    {
        "akinsho/toggleterm.nvim",
        config = function()
            local toggleterm = require("toggleterm")

            toggleterm.setup({
                shade_terminals = true,
            })

            local Terminal = require("toggleterm.terminal").Terminal
            local tig = Terminal:new({
                cmd = "tig status",
                dir = "git_dir",
                direction = "float",
                float_opts = {
                    border = "double",
                },
                -- function to run on opening the terminal
                on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(
                        term.bufnr,
                        "n",
                        "q",
                        "<cmd>close<CR>",
                        { noremap = true, silent = true }
                    )
                end,
                -- function to run on closing the terminal
                on_close = function(term)
                    vim.cmd("Closing terminal")
                end,
            })

            function _tigToggle()
                tig:toggle()
            end

            vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _tigToggle()<CR>", { noremap = true, silent = true })
        end,
        keys = { "<Leader>g" },
    },

    -- SQL language server extension
    {
        "nanotee/sqls.nvim",
        ft = { "sql" },
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "mattn/vim-sqlfmt",
        ft = { "sql" },
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lsp-document-symbol" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            { "hrsh7th/cmp-path" },
            { "onsails/lspkind.nvim" },
            { "saadparwaiz1/cmp_luasnip" },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
                event = "InsertEnter",
                config = function()
                    local luasnip = require("luasnip")
                    local types = require("luasnip.util.types")

                    luasnip.config.set_config({
                        history = true,
                        updateevents = "TextChanged,TextChangedI",
                        delete_check_events = "TextChanged",
                        ext_opts = { [types.choiceNode] = { active = { virt_text = { { "choiceNode", "Comment" } } } } },
                        ext_base_prio = 300,
                        ext_prio_increase = 1,
                        enable_autosnippets = true,
                        ft_func = function()
                            return vim.split(vim.bo.filetype, ".", true)
                        end,
                    })

                    require("luasnip.loaders.from_lua").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
                    })

                    vim.cmd(
                        [[imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']]
                    )
                    vim.cmd(
                        [[smap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']]
                    )
                end,
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
            },
            { "zbirenbaum/copilot-cmp" },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            require("copilot_cmp").setup()

            lspkind.init({
                mode = "symbol_text",
                preset = "codicons",
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "copilot" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    }),
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })

            cmp.setup.cmdline("/", {
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.setup.cmdline(":", {
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "spell" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.setup.filetype("markdown", {
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })
        end,
    },

    -- nvim-lsp
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "nvimdev/lspsaga.nvim" },
        },
        cond = function()
            -- ignore filetype markdown
            return vim.bo.filetype ~= "markdown"
        end,
        config = function()
            local group_name = "MyLspConfig"
            vim.api.nvim_create_augroup(group_name, { clear = true })

            -- Set diagnostics to location list
            autocmd({ "DiagnosticChanged" }, {
                group = group_name,
                pattern = "*",
                callback = function()
                    vim.diagnostic.setloclist({ open = false })
                end,
            })

            local nvim_lsp = require("lspconfig")
            require("lspsaga").setup({
                symbol_in_winbar = {
                    enable = true,
                },
                finder = {
                    keys = {
                        shuttle = "[w",
                        toggle_or_open = "<CR>",
                        vsplit = "v",
                        split = "s",
                        tabe = "t",
                        tabnew = "r",
                        quit = "q",
                        close = "<C-c>k",
                    },
                },
            })

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                -- builtin lsp
                vim.keymap.set("n", "<LocalLeader>n", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<LocalLeader>R", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<C-l>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "<LocalLeader>e", vim.diagnostic.open_float, bufopts)
                vim.keymap.set("n", "<LocalLeader>d", vim.diagnostic.setloclist, bufopts)
                -- lsp saga
                vim.keymap.set("n", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", bufopts)
                vim.keymap.set("i", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", bufopts)
                vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
                vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
                vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>", bufopts)
                vim.keymap.set("n", "<LocalLeader>i", "<cmd>Lspsaga finder imp<CR>", bufopts)
            end

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    -- Enable underline, use default values
                    underline = true,
                    -- Enable virtual text, override spacing to 4
                    virtual_text = {
                        spacing = 4,
                    },
                    -- Use a function to dynamically turn signs off
                    -- and on, using buffer local variables
                    signs = function(namespace, bufnr)
                        return vim.b[bufnr].show_signs == true
                    end,
                    -- Disable a feature
                    update_in_insert = false,
                })

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            require("mason").setup()
            local servers = {
                "gopls",
                "rust_analyzer",
                "tsserver",
                "lua_ls",
                -- "solargraph",
                -- "rubocop",
                -- "ruby_ls",
                "sqls",
            }
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup({
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 150,
                    },
                })
            end

            nvim_lsp.gopls.setup({
                on_attach = on_attach,
                settings = {
                    gopls = {
                        ["Formatting.local"] = "github.com/MobilityTechnologies",
                    },
                },
            })

            nvim_lsp.sqls.setup({
                on_attach = on_attach,
                cmd = {
                    "sqls",
                    "-log",
                    os.getenv("HOME") .. "/sqls.log",
                    "-config",
                    os.getenv("HOME") .. "/.config/sqls/config.yml",
                },
                -- cmd = { 'sqls', '-config', os.getenv("HOME") .. '/.config/sqls/config.yml' },
                settings = {
                    sqls = {
                        connections = {
                            {
                                driver = "mysql",
                                dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
                            },
                            {
                                driver = "postgresql",
                                dataSourceName = "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
                            },
                        },
                    },
                },
            })

            nvim_lsp.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "4",
                            },
                        },
                    },
                },
            })

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
        event = "LspAttach",
        config = function()
            require("fidget").setup()
        end,
    },
    {
        "stevearc/aerial.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("aerial").setup({
                backends = { "lsp", "treesitter", "markdown" },
            })
            require("telescope").load_extension("aerial")
        end,
        keys = {
            { "]]", "<cmd>AerialNext<CR>", mode = "n", desc = "jump prev symbol" },
            { "[[", "<cmd>AerialPrev<CR>", mode = "n", desc = "jump next symbol" },
            { "<Leader>o", "<cmd>AerialToggle!<CR>", mode = "n", desc = "open symbol list" },
            { "<C-j><C-o>", "<Cmd>Telescope aerial<CR>", mode = "n", desc = "fuzzy search symbol list" },
        },
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<LocalLeader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { { "prettier" } },
                typescript = { { "prettier" } },
                typescriptreact = { { "prettier" } },
                json = { { "prettier" } },
                go = { "goimports", "gofmt" },
            },
            format_on_save = { timeout_ms = 300, lsp_fallback = true },
        },
    },
    {
        "dmmulroy/ts-error-translator.nvim",
        ft = {
            "typescript",
            "typescript.tsx",
            "typescriptreact",
        },
        config = function()
            require("ts-error-translator").setup()
        end,
    },

    -- Fuzzy Finder
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
                    map("n", "<C-j><C-p>", "<Cmd>Telescope git_files<CR>", kopts)
                    map("n", "<C-j><C-s>", "<Cmd>Telescope git_status<CR>", kopts)
                    map("n", "<C-j><C-b>", "<Cmd>Telescope buffers<CR>", kopts)
                    map("n", "<C-j><C-]>", "<Cmd>Telescope lsp_workspace_symbols<CR>", kopts)
                    map("n", "<C-j><C-r>", "<Cmd>Telescope oldfiles<CR>", kopts)
                    map("n", "<C-j><C-e>", "<Cmd>Telescope live_grep<CR>", kopts)
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

    {
        "CRAG666/code_runner.nvim",
        cmd = {
            "RunCode",
            "RunFile",
            "RunProject",
            "RunClose",
            "CRFiletype",
            "CRProjects",
        },
        init = function()
            map("n", "<leader>r", ":RunCode<CR>", kopts)
            map("n", "<leader>rf", ":RunFile<CR>", kopts)
            map("n", "<leader>rft", ":RunFile tab<CR>", kopts)
            map("n", "<leader>rp", ":RunProject<CR>", kopts)
            map("n", "<leader>rc", ":RunClose<CR>", kopts)
            map("n", "<leader>crf", ":CRFiletype<CR>", kopts)
            map("n", "<leader>crp", ":CRProjects<CR>", kopts)
        end,
        config = function()
            require("code_runner").setup({
                filetype = {
                    python = "python3 -u",
                    typescript = "deno run",
                    rust = {
                        "cd $dir &&",
                        "rustc $fileName &&",
                        "$dir/$fileNameWithoutExt",
                    },
                    go = {
                        "cd $dir &&",
                        "go run $fileName &&",
                    },
                },
            })
        end,
    },

    -- Translate sneak and camel
    {
        "nicwest/vim-camelsnek",
        cmd = {
            "Snek",
            "Camel",
            "CamelB",
            "Kebab",
            "Screm",
        },
    },

    -- Browser
    {
        "tyru/open-browser.vim",
        event = "VeryLazy",
        config = function()
            map("n", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("x", "<Leader>bb", "<Plug>(openbrowser-smart-search)", mapopts)
            map("n", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
            map("x", "<Leader>bh", "<Cmd>OpenGithubFile<CR>", kopts)
        end,
        dependencies = { "tyru/open-browser-github.vim" },
    },

    -- Markdown edit
    {
        "ixru/nvim-markdown",
        ft = { "markdown" },
        init = function()
            local group_name = "PluginNvimMarkdown"
            augroup(group_name, { clear = true })
            autocmd("FileType", {
                group = group_name,
                pattern = { "markdown" },
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "]]", "<Plug>Markdown_MoveToNextHeader", bufopts)
                    vim.keymap.set("n", "[[", "<Plug>Markdown_MoveToPreviousHeader", bufopts)
                    vim.keymap.set("n", "<C-k>", "<Plug>Markdown_FollowLink", bufopts)
                    vim.keymap.set("n", "O", "<Plug>Markdown_NewLineAbove", bufopts)
                    vim.keymap.set("n", "o", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<Enter>", "<Plug>Markdown_NewLineBelow", bufopts)
                    vim.keymap.set("i", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                    vim.keymap.set("x", "<C-k>", "<Plug>Markdown_CreateLink", bufopts)
                end,
            })
        end,
        config = function()
            vim.g.vim_markdown_no_default_key_mappings = 1
        end,
    },
    {
        "mattn/vim-maketable",
        cmd = { "MakeTable" },
    },
    {
        "folke/zen-mode.nvim",
        cmd = { "ZenMode" },
        config = function()
            require("zen-mode").setup({})
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        ft = { "markdown" },
        config = true,
    },

    -- Text object extension
    {
        "machakann/vim-sandwich",
        config = function()
            map("n", "s", "<Nop>", kopts)
            map("x", "s", "<Nop>", kopts)
        end,
        keys = {
            { "s", mode = "n" },
            { "s", mode = "x" },
        },
    },

    -- Project management
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn" },
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            })
        end,
    },

    -- Golang extensions
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        init = function()
            map("n", "<LocalLeader>b", "<Cmd>GoBuild<CR>", kopts)
            map("n", "<LocalLeader>m", "<Cmd>GoImport<CR>", kopts)
            map("n", "<LocalLeader>a", "<Cmd>GoAlt<CR>", kopts)
        end,
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },

    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
    },
    {
        "Wansmer/treesj",
        keys = {
            { "<Leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        },
        opts = { use_default_keymaps = false, max_join_length = 1500 },
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%H:%M"],
                    augend.date.alias["%Y年%-m月%-d日"],
                    augend.date.alias["%Y年%-m月%-d日(%ja)"],
                    augend.constant.alias.ja_weekday_full,
                },
            })
        end,
        keys = {
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "normal")
                end,
                mode = "n",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "normal")
                end,
                mode = "n",
                desc = "dial decrement",
            },
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "visual")
                end,
                mode = "v",
                desc = "dial increment",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "visual")
                end,
                mode = "v",
                desc = "dial decrement",
            },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
    },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true,
        event = "VeryLazy",
    },

    {
        "keaising/im-select.nvim",
        lazy = false,
        config = function()
            if vim.fn.has("macunix") == 1 then
                require("im_select").setup({
                    default_im_select = "com.apple.keylayout.US",
                    default_command = "im-select",
                    async_switch_im = false,
                })
            else
                require("im_select").setup({
                    default_im_select = "keyboard-us",
                    default_command = "fcitx5-remote",
                    async_switch_im = false,
                })
            end
        end,
    },

    {
        "folke/neodev.nvim",
        ft = "lua",
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        opts = {},
    },

    {
        "gbprod/yanky.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("yanky").setup({
                highlight = {
                    on_put = true,
                    on_yank = true,
                    timer = 300,
                },
            })
            require("telescope").load_extension("yank_history")
            map("n", "<Leader>p", "<Cmd>Telescope yank_history<CR>", kopts)
        end,
        keys = {
            {
                "<Leader p>",
                "<Cmd>Telescope yank_history<CR>",
                mode = "n",
                desc = "select yank history normal mode",
            },
            {
                "<C-r>",
                "<Cmd>Telescope yank_history<CR>",
                mode = "i",
                desc = "select yank history insert mode",
            },
        },
    },

    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        config = function()
            local helpers = require("incline.helpers")
            local devicons = require("nvim-web-devicons")
            require("incline").setup({
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                    if filename == "" then
                        filename = "[No Name]"
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
                            or "",
                        " ",
                        { filename, gui = modified and "bold,italic" or "bold" },
                        " ",
                        guibg = "#44406e",
                    }
                end,
            })
        end,
    },

    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-neotest/neotest-go",
            "marilari88/neotest-vitest",
        },
        config = function()
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            require("neotest").setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-go"),
                },
            })
        end,
        keys = {
            {
                "<Leader>ss",
                function()
                    require("neotest").run.run()
                end,
                mode = "n",
                desc = "Run the nearest test",
            },
            {
                "<Leader>sc",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                mode = "n",
                desc = "Run the current file",
            },
            {
                "<Leader>sf",
                function()
                    require("neotest").summary.toggle()
                end,
                mode = "n",
                desc = "Open test output to the floating window",
            },
            {
                "<Leader>so",
                function()
                    require("neotest").summary.toggle()
                end,
                mode = "n",
                desc = "Open test summary panel",
            },
            {
                "<Leader>sp",
                function()
                    require("neotest").output_panel.toggle()
                end,
                mode = "n",
                desc = "Open test output panel",
            },
            {
                "<Leader>sw",
                function()
                    require("neotest").watch.toggle(vim.fn.expand("%"))
                end,
                mode = "n",
                desc = "Watch the current file test",
            },
        },
    },

    {
        "petertriho/nvim-scrollbar",
        event = "VeryLazy",
        dependencies = {
            "kevinhwang91/nvim-hlslens",
            "lewis6991/gitsigns.nvim",
        },
        config = function()
            require("scrollbar").setup()
            require("scrollbar.handlers.search").setup()
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
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
}
