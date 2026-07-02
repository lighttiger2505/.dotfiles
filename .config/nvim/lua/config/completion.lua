-- Enable inline completion
vim.schedule(function()
    vim.lsp.inline_completion.enable()
end)

vim.keymap.set("i", "<Tab>", function()
    if not vim.lsp.inline_completion.get() then
        return "<Tab>"
    end
end, { expr = true, desc = "Accept the current inline completion" })
vim.keymap.set({ "i", "n" }, "<C-j>", function()
    vim.lsp.inline_completion.select({ count = 1 })
end, { desc = "Next inline completion" })
vim.keymap.set({ "i", "n" }, "<C-k>", function()
    vim.lsp.inline_completion.select({ count = -1 })
end, { desc = "Prev inline completion" })
