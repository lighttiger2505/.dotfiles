local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
    vim.notify("This extension requires nvim-telescope/telescope.nvim", vim.log.levels.ERROR)
    return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- PR番号は opts.pr に。省略時は現在のブランチ名を使う
local function gh_pr_changes(opts)
    opts = opts or {}
    local pr = opts.pr or vim.fn.systemlist({ "git", "rev-parse", "--abbrev-ref", "HEAD" })[1]
    if pr == "" then
        vim.notify("Failed to detect current branch", vim.log.levels.ERROR)
        return
    end

    -- gh コマンドで変更ファイル一覧を取得
    local cmd = { "gh", "pr", "diff", pr, "--name-only" }
    local results = vim.fn.systemlist(cmd)
    if vim.v.shell_error ~= 0 then
        vim.notify("gh pr diff failed:\n" .. table.concat(results, "\n"), vim.log.levels.ERROR)
        return
    end

    pickers
        .new(opts, {
            prompt_title = "PR Changes: " .. pr,
            finder = finders.new_table({
                results = results,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = entry,
                        ordinal = entry,
                    }
                end,
            }),
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                -- <CR> でファイルを開く
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.cmd("edit " .. vim.fn.fnameescape(selection.value))
                end)
                return true
            end,
        })
        :find()
end

return telescope.register_extension({
    exports = {
        gh_pr_changes = gh_pr_changes,
    },
})
