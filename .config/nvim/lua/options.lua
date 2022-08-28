local g = vim.g
local opt = vim.opt

-- Skip some remote provider loading
g.loaded_python3_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
  'netrwPlugin',
}

for i = 1, 10 do
  g['loaded_' .. disabled_built_ins[i]] = 1
end


-- Fix guitter size
opt.signcolumn = 'yes:1'

-- Drawing speed more fast
opt.lazyredraw = true
opt.ttyfast = true

-- Backup
opt.backup = false
-- opt.backupdir = vim.fn.stdpath("state") .. "/backup/"
-- vim.fn.mkdir(vim.o.backupdir, "p")

-- Swap
opt.swapfile = false
-- opt.directory = vim.fn.stdpath("state") .. "/swap/"
-- vim.fn.mkdir(vim.o.directory, "p")

-- Create undo file
opt.undofile = true
-- opt.undodir = vim.fn.stdpath("state") .. "/undo/"
-- vim.fn.mkdir(vim.o.undodir, "p")

-- Show column number
opt.number = true
opt.relativenumber = true

-- Long text
opt.wrap = true
opt.textwidth = 0
-- opt.colorcolumn = 1024

-- Invisible stirng
opt.list = true
opt.listchars = "tab:»-,extends:»,precedes:«,nbsp:%,eol:↲,trail:~"

-- Don't unload buffer when it is abandones
opt.hidden = true

-- New load buffer is use open
opt.switchbuf = "useopen"

-- Smart insert tab setting.
opt.smarttab = true

-- Excahnge tab to space.
opt.expandtab = true

-- Auto insert indent.
opt.autoindent = true

-- Round indent to multipul of shiftwidth
opt.shiftround = true

-- Space insert by autoindent
opt.tabstop = 4
opt.scrolloff = 15

-- Splitting a window will put the new window below the current one.
opt.splitbelow = true
-- Splitting a window will put the new window right the current one.
opt.splitright = true
-- Set minimal width for current window.
opt.winwidth = 30
-- Set minimal height for current window.
opt.winheight = 1
-- Set maximam maximam command line window.
opt.cmdwinheight=5
-- No equal window size.
opt.equalalways = false
-- Adjust window size of preview and help.
opt.previewheight = 8
opt.helpheight = 12

-- show tab line
opt.showtabline = 2

-- Ignore case is search patterns
opt.ignorecase = true

-- No ignore case when pattern has uppercase
opt.smartcase = true

-- Search is incremental search
opt.incsearch = true

-- Replace incremental
opt.inccommand = "split"

-- 24-bit color support
opt.termguicolors = true

-- Pum options
opt.wildoptions = "pum"
opt.pumblend=10

-- Show search result highlight
opt.hlsearch = true

-- Sharing to clipborad of OS
vim.cmd[[set clipboard+=unnamedplus]]

-- Disable fold
opt.foldenable = false

-- Use ripgrep
opt.grepprg = 'rg --vimgrep --hidden'
opt.grepformat = '%f:%l:%c:%m'

-- Number of characters to apply syntax per line
opt.synmaxcol = 512

-- Disable sql omni complete
g.omni_sql_no_default_maps = 1
