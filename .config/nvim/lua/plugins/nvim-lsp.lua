local autocmd = vim.api.nvim_create_autocmd
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
        enable = false
    },
    finder = {
        keys = {
            shuttle = '[w',
            toggle_or_open = '<CR>',
            vsplit = 'v',
            split = 's',
            tabe = 't',
            tabnew = 'r',
            quit = 'q',
            close = '<C-c>k',
        }
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
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
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
    }
)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
require("mason").setup()
local servers = {
    "gopls",
    "rust_analyzer",
    "tsserver",
    "lua_ls",
    "solargraph",
    "rubocop",
    "ruby_ls",
    "sqls",
}
require("mason-lspconfig").setup({
    ensure_installed = servers,
})
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

nvim_lsp.gopls.setup {
    on_attach = on_attach,
    settings = {
        gopls = {
            ["Formatting.local"] = 'github.com/MobilityTechnologies',
        },
    },
}

nvim_lsp.sqls.setup {
    on_attach = on_attach,
    cmd = { 'sqls', '-log', os.getenv("HOME") .. '/sqls.log', '-config', os.getenv("HOME") .. '/.config/sqls/config.yml' },
    -- cmd = { 'sqls', '-config', os.getenv("HOME") .. '/.config/sqls/config.yml' },
    settings = {
        sqls = {
            connections = {
                {
                    driver = 'mysql',
                    dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world',
                },
                {
                    driver = 'postgresql',
                    dataSourceName = 'host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
                },
            },
        },
    },
}

nvim_lsp.lua_ls.setup {
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
                }
            },
        },
    },
}

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
