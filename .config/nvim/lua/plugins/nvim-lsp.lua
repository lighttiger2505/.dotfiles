local map = vim.keymap.set
local bmap = vim.api.nvim_buf_set_keymap

local autocmd = vim.api.nvim_create_autocmd
local group_name = "MyLspConfig"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- Set diagnostics to location list
autocmd({ "DiagnosticChanged" }, {
    group = group_name,
    pattern = '*',
    callback = function()
        vim.diagnostic.setloclist({ open = false })
    end,
})

-- Format on save
autocmd({ "BufWritePre" }, {
    group = group_name,
    pattern = { '*.go', '*.lua' },
    callback = function()
        vim.lsp.buf.formatting_sync()
    end,
})

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    bmap(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', '<C-]>', vim.lsp.buf.definition, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', '<LocalLeader>n', vim.lsp.buf.references, bufopts)
    map('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)
    map('n', '<LocalLeader>i', vim.lsp.buf.implementation, bufopts)
    map('n', '<C-l>', vim.lsp.buf.signature_help, bufopts)
    map('i', '<C-l>', vim.lsp.buf.signature_help, bufopts)
    map('n', '[d', vim.diagnostic.goto_prev, bufopts)
    map('n', ']d', vim.diagnostic.goto_next, bufopts)
    map('n', '<LocalLeader>e', vim.diagnostic.open_float, bufopts)
    map('n', '<LocalLeader>d', vim.diagnostic.setloclist, bufopts)
    map('n', '<LocalLeader>f', vim.lsp.buf.formatting, bufopts)
    map('n', '<LocalLeader>c', vim.lsp.buf.code_action, bufopts)
    map('n', '<LocalLeader>o', vim.lsp.buf.document_symbol, bufopts)
    map('n', '<LocalLeader>w', vim.lsp.buf.workspace_symbol, bufopts)
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
local servers = { 'gopls', 'pyright', 'rust_analyzer', 'tsserver', 'sumneko_lua', 'metals' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

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

nvim_lsp.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
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
