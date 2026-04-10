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
        session_lens = {
            picker = "telescope",
            mappings = {
                delete_session = { "i", "<C-d>" },
                alternate_session = { "i", "<C-s>" },
                copy_session = { "i", "<C-y>" },
            },
            load_on_setup = true,
        },
    },
}
