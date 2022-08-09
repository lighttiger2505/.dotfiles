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
    local hls_status = vim.v.hlsearch
    for name, _ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end

    dofile(os.getenv("HOME") .. "/.dotfiles/init.lua")
    if hls_status == 0 then
        vim.opt.hlsearch = false
    end
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

return require('packer').startup(function(use)
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
        config = function() LoadPluginConfig("neo-tree.rc.lua") end,
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
        config = function() LoadPluginConfig("diffview.rc.lua") end,
    }

    use "nathom/filetype.nvim"
    use "mattn/sonictemplate-vim"

    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function() LoadPluginConfig("null-ls.rc.lua") end,
    }

    use {
        'akinsho/toggleterm.nvim',
        config = function() LoadPluginConfig("toggleterm.rc.lua") end,
    }

    use {
        'nanotee/sqls.nvim',
        ft = { "sql" },
        requires = { "nvim-lua/plenary.nvim" },
    }

    -- nvim-cmp
    use { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "f3fora/cmp-spell", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
    use {
        'hrsh7th/nvim-cmp',
        config = function() LoadPluginConfig("nvim-cmp.rc.lua") end,
        event = 'InsertEnter',
    }

    -- nvim-lsp
    use {
        'neovim/nvim-lspconfig',
        config = function() LoadPluginConfig("nvim-lsp.rc.lua") end,
    }
    use {
        "j-hui/fidget.nvim",
        config = function() require('gitsigns').setup() end,
        requires = { "neovim/nvim-lspconfig" },
    }
    use {
        "simrat39/symbols-outline.nvim",
        config = function() LoadPluginConfig("symbols-outline.rc.lua") end,
        requires = { "neovim/nvim-lspconfig" },
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        setup = function()
            local fzfopts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<C-j><C-p>', '<Cmd>Telescope git_files<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-s>', '<Cmd>Telescope git_status<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-b>', '<Cmd>Telescope buffers<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-]>', '<Cmd>Telescope lsp_workspace_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-o>', '<Cmd>Telescope lsp_document_symbols<CR>', fzfopts)
            vim.api.nvim_set_keymap('n', '<C-j><C-r>', '<Cmd>Telescope oldfiles<CR>', fzfopts)
        end,
    }

    use {
        'akinsho/toggleterm.nvim',
        config = function() LoadPluginConfig("toggleterm.rc.lua") end,
    }

    if Packer_bootstrap then
        require('packer').sync()
    end
end)
