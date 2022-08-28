local toggleterm = require("toggleterm")

toggleterm.setup {
  shade_terminals = true,
}

local Terminal = require('toggleterm.terminal').Terminal
local tig      = Terminal:new({
  cmd = "tig status",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _tigToggle()
  tig:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _tigToggle()<CR>", { noremap = true, silent = true })
