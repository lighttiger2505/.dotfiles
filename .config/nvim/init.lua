require("plugins")

vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/mappings.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/options.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/filetype.rc.vim")
vim.cmd("source " .. os.getenv("HOME") .. "/.vim/rc/autocmd.rc.vim")

local function exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

vim.o.background = "dark"
if exists(vim.fn.stdpath("data") .. "/site/pack/packer/start/gruvbox.nvim") then
    vim.cmd([[colorscheme gruvbox]])
else
    vim.cmd([[colorscheme desert]])
end
