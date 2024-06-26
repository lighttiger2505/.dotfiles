local autocmd = vim.api.nvim_create_autocmd
local l = vim.opt_local

local group_name = "MyConfig"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- envrc filetype
autocmd({ 'BufRead', 'BufNewFile' }, {
  group = group_name,
  pattern = { ".envrc" },
  callback = function()
    l.filetype = 'sh'
  end,
})

-- Disable markdown collapse
autocmd('FileType', {
  group = group_name,
  pattern = { "markdown" },
  callback = function()
    l.conceallevel = 3
    l.concealcursor = "c"
  end,
})

-- Spell check gitcommit
autocmd('FileType', {
  group = group_name,
  pattern = { 'gitcommit', 'NeogitCommitMessage' },
  callback = function()
    l.spell = true
  end,
})

-- Save last cursor position
autocmd('BufRead', {
  group = group_name,
  pattern = { '*' },
  command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]],
})

-- Show quickfix after grepcmd
autocmd('QuickFixCmdPost', {
  group = group_name,
  pattern = { 'vim', 'grep', 'make' },
  command = [[if len(getqflist()) != 0 | cwindow | endif]],
})

-- Tarminal buffer guitter
autocmd('TermOpen', {
  group = group_name,
  callback = function()
    l.relativenumber = false
    l.number = false
  end,
})

-- Tarminal buffer guitter
autocmd('TextYankPost', {
  group = group_name,
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})
