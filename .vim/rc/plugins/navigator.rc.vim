lua <<EOF
require'navigator'.setup({
  debug = false, 
  width = 0.75,
  height = 0.3,
  preview_height = 0.35,
  border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},

  default_mapping = false,
  keymaps = {{key = "gK", func = "declaration()"}},
  treesitter_analysis = false,
  transparency = 50,
  icons = {
    code_action_icon = "🏏",
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = "🈲",
  },
  lsp_installer = false,
  lsp = {
    code_action = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    },
    code_lens_action = {
        enable = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true
    },
    format_on_save = false,
    disable_format_cap = {"sqls", "lua_ls", "gopls"}, 
    disable_lsp = {'pylsd', 'sqlls'},
    diagnostic_scroll_bar_sign = {'▃', '▆', '█'},
    diagnostic_virtual_text = true,
    diagnostic_update_in_insert = false,
    disply_diagnostic_qf = true,
  }
})
EOF
