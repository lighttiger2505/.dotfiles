local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer')
packer.init {
    display = {
        open_fn = require 'packer.util'.float,
    },
    profile = {
        enable = false,
        threshold = 1,
    },
}
return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim'

    -- colorschema
    use { 'ellisonleao/gruvbox.nvim' }

    -- libs
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use "MunifTanjim/nui.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        config = function() require("plugins.lualine") end,
    }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        cmd = { "Neotree" },
        config = function() require("plugins.neo-tree") end,
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>t', ':Neotree toggle<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<Leader>f', ':Neotree reveal<CR>', { noremap = true, silent = true })
        end,
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    }

    -- tree-sitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function() require("plugins.nvim-treesitter") end,
        run = ':TSUpdate',
    }
    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function() require("plugins.nvim-treesitter-textobjects") end,
        after = { "nvim-treesitter" },
    }
    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function() require("plugins.nvim-ts-context-commentstring") end,
        after = { "nvim-treesitter" },
    }

    -- Profiling
    use { 'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]] }

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function() require("plugins.Comment") end,
        requires = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        }
    }

    -- Indent
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require("plugins.indent-blankline") end,
    }

    -- Git Hunk
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end,
    }

    -- Search
    use {
        "haya14busa/vim-asterisk",
        setup = function()
            vim.cmd [[map *  <Plug>(asterisk-z*)]]
            vim.cmd [[map #  <Plug>(asterisk-z#)]]
            vim.cmd [[map g* <Plug>(asterisk-gz*)]]
            vim.cmd [[map g# <Plug>(asterisk-gz#)]]
        end,
    }
    use {
        'kevinhwang91/nvim-hlslens',
        config = function() require("plugins.hlslens") end,
        requires = { 'haya14busa/vim-asterisk' }
    }

    -- use {
    --     'ethanholz/nvim-lastplace',
    --     config = function() require('nvim-lastplace').setup {} end,
    -- }

    -- use {
    --     'TimUntersberger/neogit',
    --     config = function() LoadPluginConfig("neogit.rc.lua") end,
    -- }

    -- Code diff view
    use {
        'sindrets/diffview.nvim',
        cmd = { "DiffviewOpen" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>d', ':DiffviewOpen<CR>', { noremap = true, silent = true })
        end,
        config = function() require("plugins.diffview") end,
    }

    -- Syntax
    use "sheerun/vim-polyglot"
    use "nathom/filetype.nvim"

    -- Template
    use "mattn/sonictemplate-vim"

    -- General language server
    use {
        'jose-elias-alvarez/null-ls.nvim',
        ft = {
            'javascript',
            'javascript.jsx',
            'javascriptreact',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
        },
        config = function() require("plugins.null-ls") end,
    }

    -- Toggle terminal
    use {
        'akinsho/toggleterm.nvim',
        config = function() require("plugins.toggleterm") end,
    }

    -- SQL language server extension
    use {
        'nanotee/sqls.nvim',
        ft = { "sql" },
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- LuaSnip
    use {
        "rafamadriz/friendly-snippets",
        opt = true,
    }
    use {
        "L3MON4D3/LuaSnip",
        event = 'InsertEnter',
        config = function() require("plugins.LuaSnip") end,
    }
    use {
        "benfowler/telescope-luasnip.nvim",
        after = { "telescope.nvim", "LuaSnip" },
        config = function()
            require("telescope").load_extension("luasnip")
        end,
    }

    -- nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "f3fora/cmp-spell", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
        },
        after = 'LuaSnip',
        config = function() require("plugins.nvim-cmp") end,
    }

    -- nvim-lsp
    use {
        'neovim/nvim-lspconfig',
        config = function() require("plugins.nvim-lsp") end,
    }
    use {
        'williamboman/mason.nvim',
        config = function() require("mason").setup() end,
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    'gopls',
                    'tsserver',
                    'sumneko_lua',
                    'metals',
                }
            })
        end,
    }
    use {
        "j-hui/fidget.nvim",
        requires = { "neovim/nvim-lspconfig" },
        config = function() require('fidget').setup() end,
    }
    use {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        requires = { "neovim/nvim-lspconfig" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>o', ':SymbolsOutline<CR>', { noremap = true, silent = true })
        end,
        config = function() require("plugins.symbols-outline") end,
    }

    -- Fuzzy Finder
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        cmd = 'Telescope',
        setup = function()
            local fzfopts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<C-j><C-p>', '<Cmd>Telescope git_files<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-s>', '<Cmd>Telescope git_status<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-b>', '<Cmd>Telescope buffers<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-]>', '<Cmd>Telescope lsp_workspace_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-o>', '<Cmd>Telescope lsp_document_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-r>', '<Cmd>Telescope oldfiles<CR>', fzfopts)
        end,
        config = function() require("plugins.telescope") end,
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    -- vim-quickrun
    use {
        'thinca/vim-quickrun',
        cmd = { "QuickRun" },
        requires = { "lambdalisue/vim-quickrun-neovim-job", after = 'vim-quickrun' },
        config = function() LoadVimPluginConfig("vimquickrun.rc.vim") end,
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>QuickRun<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('x', '<Leader>r', '<Cmd>QuickRun<CR>', { noremap = true, silent = true })
        end,
    }

    -- Translate sneak and camel
    use "nicwest/vim-camelsnek"

    use {
        'prettier/vim-prettier',
        opt = true,
        ft = {
            'javascript',
            'javascript.jsx',
            'javascriptreact',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
        },
    }

    -- Browser
    use {
        'tyru/open-browser.vim',
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>bb', '<Plug>(openbrowser-smart-search)<CR>',
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('x', '<Leader>bb', '<Plug>(openbrowser-smart-search)<CR>',
                { noremap = true, silent = true })
        end,
    }
    use {
        'tyru/open-browser-github.vim',
        after = { "open-browser.vim" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>bh', '<Cmd>OpenGithubFile<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('x', '<Leader>bh', '<Cmd>OpenGithubFile<CR>', { noremap = true, silent = true })
        end,
    }

    -- Markdown preview
    use {
        'kannokanno/previm',
        after = { "open-browser.vim" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>PrevimOpen<CR>', { noremap = true, silent = true })
        end,
    }

    -- Text object extension
    use {
        'machakann/vim-sandwich',
        setup = function()
            vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('x', 's', '<Nop>', { noremap = false, silent = true })
        end,
    }

    -- Highlight yank
    use {
        'machakann/vim-highlightedyank',
        setup = function()
            vim.g.highlightedyank_highlight_duration = 200
        end,
    }

    -- Project management
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                manual_mode = false,
                detection_methods = { "lsp", "pattern" },
                patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                show_hidden = false,
                silent_chdir = true,
                datapath = vim.fn.stdpath("data"),
            }
        end
    }

    -- Golang extensions
    use {
        'ray-x/go.nvim',
        requires = "ray-x/guihua.lua",
        config = function()
            require('go').setup()
        end,
        setup = function()
            vim.api.nvim_set_keymap('n', '<LocalLeader>b', 'GoBuild', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('n', '<LocalLeader>tt', 'GoTestFile', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('n', '<LocalLeader>tf', 'GoTestFunc', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('n', '<LocalLeader>m', 'GoImport', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('n', '<LocalLeader>a', 'GoAlt', { noremap = false, silent = true })
        end,
    }

    -- Register
    use {
        'tversteeg/registers.nvim',
        cmd = 'Registers',
        setup = function()
            vim.api.nvim_set_keymap('n', '<C-r>', '<Cmd>Registers<CR>', { noremap = false, silent = true })
        end,
    }

    if Packer_bootstrap then
        require('packer').sync()
    end
end)
