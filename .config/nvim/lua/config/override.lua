do
    -- Replace buf_get_clients() with an implementation that does not produce warnings
    vim.lsp.buf_get_clients = function(bufnr)
        if bufnr == nil then
            bufnr = 0
        end
        return vim.lsp.get_clients({ bufnr = bufnr })
    end
    if vim.lsp.get_active_clients then
        vim.lsp.get_active_clients = function(filter)
            filter = filter or {}
            return vim.lsp.get_clients(filter)
        end
    end
end
