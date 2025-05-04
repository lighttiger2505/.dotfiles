require("config.mappings")
require("config.options")
require("config.autocmds")
require("config.lazy")
if vim.g.neovide then
    require("config.neovide")
end
