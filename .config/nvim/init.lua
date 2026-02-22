require("config.mappings")
require("config.options")
require("config.autocmds")
require("config.lazy")
require("config.override")
if vim.g.neovide then
    require("config.neovide")
end
require("config.commands")
