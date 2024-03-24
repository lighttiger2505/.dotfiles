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
map("n", "<Space>h", "<Cmd>noh<CR>", opts)

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
