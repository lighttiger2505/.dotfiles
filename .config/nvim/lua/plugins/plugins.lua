local map = vim.keymap.set
local kopts = { noremap = true, silent = true }
local mapopts = { noremap = false, silent = true }

return {
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
