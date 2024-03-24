local autocmd = vim.api.nvim_create_autocmd

return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePre" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                javascript = { "eslint" },
                typescript = { "eslint" },
                typescriptreact = { "eslint" },
                go = { "golangcilint" },
                json = { "jsonlint" },
            }
            autocmd({ "BufWritePost" }, {
                callback = function()
                    local ns = lint.get_namespace("my_linter_name")
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.diagnostic.reset(ns, bufnr)
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
