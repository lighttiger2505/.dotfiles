vim.api.nvim_exec(
    [[
    autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({open = false})
    autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
    autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
  ]] ,
    false
)

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>n', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    buf_set_keymap('n', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('i', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>d', '<cmd>lua vim.diagnostic.setloclist()()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    buf_set_keymap('n', '<LocalLeader>o', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
    buf_set_keymap('n', '<LocalLeader>w', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'pyright', 'rust_analyzer', 'tsserver', 'sumneko_lua' }
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

local fzf_lsp = require('fzf_lsp')
vim.lsp.handlers["textDocument/codeAction"] = fzf_lsp.code_action_handler
-- vim.lsp.handlers["textDocument/definition"] = fzf_lsp.definition_handler
-- vim.lsp.handlers["textDocument/declaration"] = fzf_lsp.declaration_handler
-- vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lsp.type_definition_handler
-- vim.lsp.handlers["textDocument/implementation"] = fzf_lsp.implementation_handler
-- vim.lsp.handlers["textDocument/references"] = fzf_lsp.references_handler
vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lsp.document_symbol_handler
vim.lsp.handlers["workspace/symbol"] = fzf_lsp.workspace_symbol_handler
-- vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lsp.incoming_calls_handler
-- vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lsp.outgoing_calls_handler

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
