local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    ext_opts = { [types.choiceNode] = { active = { virt_text = { { "choiceNode", "Comment" } } } } },
    ext_base_prio = 300,
    ext_prio_increase = 1,
    enable_autosnippets = true,
    ft_func = function()
        return vim.split(vim.bo.filetype, ".", true)
    end,
})

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
    paths = { vim.fn.stdpath("data") .. "/site/pack/packer/opt/friendly-snippets" },
})

vim.cmd([[imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
vim.cmd([[smap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-k>']])
