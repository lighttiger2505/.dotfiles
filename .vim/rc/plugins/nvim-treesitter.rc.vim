lua << EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "c",
      "cpp",
      "css",
      "dockerfile",
      "go",
      "javascript",
      "lua",
      "make",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
  },
  highlight = {
    enable = true,
    -- disable = {"typescript", "typescriptreact", "python", "vim"},
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = false
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

require('treesitter-context').setup{
    enable = true,
    throttle = true,
    max_lines = 0,
    patterns = {
        default = {
            'class',
            'function',
            'method',
        },
    },
}

EOF
