local autocmd = vim.api.nvim_create_autocmd
local l = vim.opt_local

local group_name = "MyConfig"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- envrc filetype
autocmd({ "BufRead", "BufNewFile" }, {
    group = group_name,
    pattern = { ".envrc" },
    callback = function()
        l.filetype = "sh"
    end,
})

autocmd("FileType", {
    group = group_name,
    pattern = { "gitcommit" },
    callback = function(ev)
        -- Spell check gitcommit
        l.spell = true
        -- generate commit message
        if vim.fn.has("codecompanion.nvim") then
            vim.schedule(function()
                require("codecompanion")
                vim.cmd("CodeCompanion /custom_commit_message")
            end)
        end
        -- autoclose codecompanion buffer
        -- :q → :qa
        vim.cmd([[cnoreabbrev <buffer> q qa]])
        -- :wq → :wqa
        vim.cmd([[cnoreabbrev <buffer> wq wqa]])
    end,
})

-- Save last cursor position
autocmd("BufRead", {
    group = group_name,
    pattern = { "*" },
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]],
})

-- Show quickfix after grepcmd
autocmd("QuickFixCmdPost", {
    group = group_name,
    pattern = { "vim", "grep", "make" },
    command = [[if len(getqflist()) != 0 | cwindow | endif]],
})

-- Tarminal buffer guitter
autocmd("TermOpen", {
    group = group_name,
    callback = function()
        l.relativenumber = false
        l.number = false
    end,
})

-- Tarminal buffer guitter
autocmd("TextYankPost", {
    group = group_name,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

autocmd("FileType", {
    group = group_name,
    pattern = { "help" },
    command = [[wincmd L]],
})

autocmd("FileType", {
    group = group_name,
    pattern = { "csv" },
    callback = function()
        l.wrap = false
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = group_name,
    callback = function()
        if vim.wo.diff then
            vim.cmd([[colorscheme desert]])
        end
    end,
})

vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "diff",
    group = group_name,
    callback = function()
        if vim.wo.diff then
            vim.cmd([[colorscheme desert]])
        else
            vim.cmd([[colorscheme catppuccin-mocha]])
        end
    end,
})
