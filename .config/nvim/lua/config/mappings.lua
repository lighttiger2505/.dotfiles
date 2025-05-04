local g = vim.g

-- Change leader mapping
g.mapleader = [[,]]
g.maplocalleader = [[\]]

local map = vim.api.nvim_set_keymap
local opts = { silent = false, noremap = true }

-- Ctrl + c = ESC for rectangle selection
map("i", "<C-c>", "<ESC>", opts)

-- Switch colon and semicolon
map("n", ";", ":", opts)
map("n", ":", ";", opts)
map("v", ";", ":", opts)
map("v", ":", ";", opts)

-- Multi line move
map("n", "k", "gk", opts)
map("n", "j", "gj", opts)
map("n", "gk", "k", opts)
map("n", "gj", "j", opts)

-- Jump front/back
map("n", "H", "^", opts)
map("n", "L", "$", opts)
map("v", "H", "^", opts)
map("v", "L", "$", opts)

-- Insert mode move
map("i", "<C-b>", "<Left>", opts)
map("i", "<C-f>", "<Right>", opts)

-- Disable close window
map("n", "<C-w>c", "<Nop>", opts)

-- Disable close window
map("n", "<C-w>>", "10<C-w>>", opts)
map("n", "<C-w><", "10<C-w><", opts)
map("n", "<C-w>+", "10<C-w>+", opts)
map("n", "<C-w>-", "10<C-w>-", opts)

-- Indent keybind for shutcut
map("n", ">", ">>", opts)
map("n", "<", "<<", opts)

-- Jump quickfix
map("n", "<C-p>", "<Cmd>cp<CR>", opts)
map("n", "<C-n>", "<Cmd>cn<CR>", opts)

-- Jump locationlist
map("n", "[t", "<Cmd>lp<CR>", opts)
map("n", "]t", "<Cmd>lne<CR>", opts)

-- Clear search hi
map("n", "?", "<Cmd>noh<CR>", opts)

-- Command line mode mapping emacs like
map("c", "<C-b>", "<Left>", opts)
map("c", "<C-f>", "<Right>", opts)
map("c", "<C-n>", "<Down>", opts)
map("c", "<C-p>", "<Up>", opts)
map("c", "<C-a>", "<Home>", opts)
map("c", "<C-e>", "<End>", opts)

-- Switch to last file
map("n", "<Space><Space>", "<c-^>", opts)

-- Escape normal mode on terminal
map("t", "<ESC>", "<C-\\><C-n>", opts)

-- Current file tab open
map("n", "<C-w>t", "<C-w>T", opts)

-- Move tab
map("n", "t", "<Nop>", opts)
map("n", "tn", "gt", opts)
map("n", "tp", "gT", opts)

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
end, { noremap = true, silent = true, desc = "Copy current file path to clipboard" })
