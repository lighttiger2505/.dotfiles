-- Set a normal mode key mapping for "yp" to copy the current file's path to the system clipboard
vim.keymap.set("n", "yp", function()
    -- Get the current buffer's full file path
    local filepath = vim.api.nvim_buf_get_name(0)
    -- Check if there is a file associated with the current buffer
    if filepath == "" then
        print("No file name available!")
        return
    end
    -- Convert the path to be relative to the current working directory
    local relative_path = vim.fn.fnamemodify(filepath, ":.")
    -- Set the relative file path into the system clipboard register "+"
    vim.fn.setreg("+", relative_path)
    -- Notify the user that the file path was copied
    print("Copied file path to clipboard: " .. relative_path)
end, { noremap = true, silent = true, desc = "Copy current file relative path to clipboard" })

vim.keymap.set("n", "yP", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        print("No file name available!")
        return
    end
    local home = vim.env.HOME
    local display_path = filepath
    if home and filepath:sub(1, #home) == home then
        display_path = "~/" .. filepath:sub(#home + 2)
    end
    vim.fn.setreg("+", display_path)
    print("Copied file path to clipboard: " .. display_path)
end, { noremap = true, silent = true, desc = "Copy current file full path to clipboard" })

vim.keymap.set("n", "<Leader><Leader>t", "<Cmd>e $VIM_MEMO_DIR/todo.md<CR>", opts)
vim.keymap.set("n", "<Leader><Leader>l", "<Cmd>e $VIM_MEMO_DIR/link.md<CR>", opts)
vim.keymap.set("n", "<Leader><Leader>f", "<Cmd>e $VIM_MEMO_DIR/feedback.md<CR>", opts)
vim.keymap.set("n", "<Leader>bp", ":!gh pr view --web<CR>", opts)

-- Enable inline completion
vim.schedule(function()
    vim.lsp.inline_completion.enable()
end)

vim.keymap.set("i", "<TAB>", function()
    vim.lsp.inline_completion.get()
end, { desc = "Accept inline completion" })
vim.keymap.set({ "i", "n" }, "<C-j>", function()
    vim.lsp.inline_completion.select({ count = 1 })
end, { desc = "Next inline completion" })
vim.keymap.set({ "i", "n" }, "<C-k>", function()
    vim.lsp.inline_completion.select({ count = -1 })
end, { desc = "Prev inline completion" })
