local lint_progress = function()
    local linters = require("lint").get_running()
    if #linters == 0 then
        return "󰦕"
    end
    return "󱉶 " .. table.concat(linters, ", ")
end

require("lualine").setup {
    options = {
        icons_enabled = true,
        theme = "nightfox",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = { "diff", lint_progress, "diagnostics" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {},
}
