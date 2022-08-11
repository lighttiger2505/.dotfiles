local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
end

-- load vim configs
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/mappings.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/options.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/filetype.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/autocmd.rc.vim")

function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end

    dofile(os.getenv("HOME") .. "/.dotfiles/init.lua")
end

function _G.LoadPluginConfig(file)
    dofile(os.getenv("HOME") .. "/.dotfiles/.vim/rc/plugins/" .. file)
end

function _G.LoadVimPluginConfig(file)
    local p = os.getenv("HOME") .. "/.dotfiles/.vim/rc/plugins/" .. file
    vim.cmd("source " .. p)
end

local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>si', '<Cmd>lua ReloadConfig()<CR>', kopts)
vim.api.nvim_set_keymap('n', '<Leader>sp', '<Cmd>:PackerSync<CR>', kopts)

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

local packer = require('packer')

packer.init {
    display = {
        open_fn = require 'packer.util'.float,
    },
}

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- colorschema
    use 'ellisonleao/gruvbox.nvim'

    -- libs
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use "MunifTanjim/nui.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        config = function() LoadPluginConfig("lualine.rc.lua") end,
    }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        opt = true,
        cmd = { "Neotree" },
        config = function() LoadPluginConfig("neo-tree.rc.lua") end,
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
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    use { "JoosepAlviste/nvim-ts-context-commentstring" }
    use {
        "nvim-treesitter/nvim-treesitter",
        config = function() LoadPluginConfig("nvim-treesitter.rc.lua") end,
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
    }

    use {
        'numToStr/Comment.nvim',
        config = function() LoadPluginConfig("Comment.rc.lua") end, requires = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        }
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function() LoadPluginConfig("indent-blankline.rc.lua") end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end,
    }

    -- asterisk
    use "haya14busa/vim-asterisk"
    use {
        'kevinhwang91/nvim-hlslens',
        config = function() LoadPluginConfig("hlslens.rc.lua") end,
        requires = { 'haya14busa/vim-asterisk' }
    }

    -- use {
    --     'TimUntersberger/neogit',
    --     config = function() LoadPluginConfig("neogit.rc.lua") end,
    -- }

    use {
        'sindrets/diffview.nvim',
        opt = true,
        cmd = { "DiffviewOpen" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>d', ':DiffviewOpen<CR>', { noremap = true, silent = true })
        end,
        config = function() LoadPluginConfig("diffview.rc.lua") end,
    }

    use "nathom/filetype.nvim"
    use "mattn/sonictemplate-vim"

    use {
        'jose-elias-alvarez/null-ls.nvim',
        opt = true,
        ft = {
            'javascript',
            'javascript.jsx',
            'javascriptreact',
            'typescript',
            'typescript.tsx',
            'typescriptreact',
        },
        config = function() LoadPluginConfig("null-ls.rc.lua") end,
    }

    use {
        'akinsho/toggleterm.nvim',
        config = function() LoadPluginConfig("toggleterm.rc.lua") end,
    }

    use {
        'nanotee/sqls.nvim',
        opt = true,
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
        event = "VimEnter",
        config = function() LoadPluginConfig("LuaSnip.rc.lua") end,
    }
    use {
        "benfowler/telescope-luasnip.nvim",
        after = { "telescope.nvim", "LuaSnip" },
        config = function()
            require("telescope").load_extension("luasnip")
        end,
    }

    -- nvim-cmp
    use { "hrsh7th/cmp-nvim-lsp", opt = true, module = "cmp_nvim_lsp" }
    use { "saadparwaiz1/cmp_luasnip", opt = true, after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", opt = true, after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", opt = true, after = "nvim-cmp" }
    use { "f3fora/cmp-spell", opt = true, after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
    use {
        'hrsh7th/nvim-cmp',
        opt = true,
        config = function() LoadPluginConfig("nvim-cmp.rc.lua") end,
        event = 'InsertEnter',
        requires = {
            { "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
        },
    }

    -- nvim-lsp
    use {
        'neovim/nvim-lspconfig',
        config = function() LoadPluginConfig("nvim-lsp.rc.lua") end,
    }
    use {
        "j-hui/fidget.nvim",
        requires = { "neovim/nvim-lspconfig" },
        config = function() LoadPluginConfig("gitsigns.rc.lua") end,
    }
    use {
        "simrat39/symbols-outline.nvim",
        opt = true,
        cmd = { "SymbolsOutline" },
        requires = { "neovim/nvim-lspconfig" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>o', ':SymbolsOutline<CR>', { noremap = true, silent = true })
        end,
        config = function() LoadPluginConfig("symbols-outline.rc.lua") end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        opt = true,
        cmd = { "Telescope" },
        setup = function()
            local fzfopts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<C-j><C-p>', '<Cmd>Telescope git_files<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-s>', '<Cmd>Telescope git_status<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-b>', '<Cmd>Telescope buffers<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-]>', '<Cmd>Telescope lsp_workspace_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-o>', '<Cmd>Telescope lsp_document_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-r>', '<Cmd>Telescope oldfiles<CR>', fzfopts)
        end,
        config = function() LoadPluginConfig("telescope.rc.lua") end,

    }

    -- vim-quickrun
    use { "lambdalisue/vim-quickrun-neovim-job", opt = true }
    use {
        'thinca/vim-quickrun',
        opt = true,
        cmd = { "QuickRun" },
        requires = { "lambdalisue/vim-quickrun-neovim-job" },
        config = function() LoadVimPluginConfig("vimquickrun.rc.vim") end,
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>QuickRun<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('x', '<Leader>r', '<Cmd>QuickRun<CR>', { noremap = true, silent = true })
        end,
    }

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

    -- open-browser.vim
    use {
        'tyru/open-browser.vim',
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>bb', '<Plug>(openbrowser-smart-search)<CR>', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('x', '<Leader>bb', '<Plug>(openbrowser-smart-search)<CR>', { noremap = true, silent = true })
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
    use {
        'kannokanno/previm',
        after = { "open-browser.vim" },
        setup = function()
            vim.api.nvim_set_keymap('n', '<Leader>p', '<Cmd>PrevimOpen<CR>', { noremap = true, silent = true })
        end,
    }

    use {
        'machakann/vim-sandwich',
        setup = function()
            vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = false, silent = true })
            vim.api.nvim_set_keymap('x', 's', '<Nop>', { noremap = false, silent = true })
        end,
    }

    use {
        'machakann/vim-highlightedyank',
        setup = function()
            vim.g.highlightedyank_highlight_duration = 200
        end,
    }

    use {
        'fatih/vim-go',
        opt = true,
        ft = { 'go' },
        config = function() LoadVimPluginConfig("go.rc.vim") end,
    }
    use { 'buoto/gotests-vim', opt = true, ft = { 'go' } }

    if Packer_bootstrap then
        require('packer').sync()
    end
end)
