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
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<LocalLeader>n', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<LocalLeader>R', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<LocalLeader>i', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-l>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('i', '<C-l>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<LocalLeader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<LocalLeader>d', vim.diagnostic.setloclist, bufopts)
    vim.keymap.set('n', '<LocalLeader>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<LocalLeader>c', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<LocalLeader>o', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', '<LocalLeader>w', vim.lsp.buf.workspace_symbol, bufopts)
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
local servers = { 'gopls', 'rust_analyzer', 'tsserver', 'sumneko_lua' }
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
        gopls = {
            analyses = {
                unusedparams = true,
            },
            formatting = {
                ["local"] = 'github.com/MobilityTechnologies',
            },
        },
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
