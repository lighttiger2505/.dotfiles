require 'impatient'
local cmd = vim.cmd

-- Utils
function _G.LoadVimPluginConfig(file)
    local p = os.getenv("HOME") .. "/.dotfiles/.vim/rc/plugins/" .. file
    vim.cmd("source " .. p)
end

-- Commands
local create_cmd = vim.api.nvim_create_user_command
create_cmd('PackerInstall', function()
    cmd [[packadd packer.nvim]]
    require('plugins').install()
end, {})
create_cmd('PackerUpdate', function()
    cmd [[packadd packer.nvim]]
    require('plugins').update()
end, {})
create_cmd('PackerSync', function()
    cmd [[packadd packer.nvim]]
    require('plugins').sync()
end, {})
create_cmd('PackerClean', function()
    cmd [[packadd packer.nvim]]
    require('plugins').clean()
end, {})
create_cmd('PackerCompile', function()
    cmd [[packadd packer.nvim]]
    require('plugins').compile()
end, {})

require('mappings')
require('options')
require('autocmds')

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
