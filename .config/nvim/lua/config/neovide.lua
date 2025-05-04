vim.o.guifont = "UDEV Gothic NFLG:h24"
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 1.0
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_scroll_animation_length = 0.1

local function parse_guifont()
    local guifont = vim.o.guifont
    local name, size = guifont:match("^(.-):h(%d+)$")
    if not name then
        name = guifont
        size = 12
    else
        size = tonumber(size)
    end
    return name, size
end

local function adjust_font_size(delta)
    local name, size = parse_guifont()
    size = size + delta
    vim.o.guifont = string.format("%s:h%d", name, size)
end

vim.keymap.set("n", "<C-=>", function()
    adjust_font_size(1)
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", function()
    adjust_font_size(-1)
end, { noremap = true, silent = true })
