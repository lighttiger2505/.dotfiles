return {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        { "<leader>wr", "<cmd>AutoSession search<CR>", desc = "Session search" },
        { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
        { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        close_unsupported_windows = true,
        bypass_save_filetypes = {
            -- git
            "gitcommit",
            "gitrebase",
        },
        close_filetypes_on_save = {
            -- git
            "gitcommit",
            "gitrebase",
            -- default
            "checkhealth",
            -- plugins
            "grug-far",
            "neo-tree",
        },
        session_lens = {
            picker = "telescope",
            mappings = {
                delete_session = { "i", "<C-d>" },
                alternate_session = { "i", "<C-s>" },
                copy_session = { "i", "<C-y>" },
            },
            load_on_setup = true,
        },
        auto_create = function()
            local cmd = vim.fn.argv(0)
            if cmd and cmd ~= "" then
                return false
            end
            return true
        end,
        pre_restore_cmds = {
            function()
                if os.getenv("NVIM_NO_SESSION") == "1" then
                    return false
                end
                return true
            end,
        },
    },
}
