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
        pre_save_cmds = {
            function()
                local cwd = vim.fn.getcwd()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if not vim.api.nvim_buf_is_loaded(buf) then
                        goto continue
                    end
                    local name = vim.api.nvim_buf_get_name(buf)
                    if name ~= "" and vim.fn.filereadable(name) == 1 then
                        if not vim.startswith(name, cwd .. "/") and name ~= cwd then
                            vim.api.nvim_buf_delete(buf, { force = false })
                        end
                    end
                    ::continue::
                end
            end,
        },
    },
}
