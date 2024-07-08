return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "onsails/lspkind.nvim" },
            { "zbirenbaum/copilot-cmp" },
            { "garymjr/nvim-snippets" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            require("copilot_cmp").setup()

            lspkind.init({
                mode = "symbol_text",
                preset = "codicons",
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp_signature_help" },
                    { name = "snippets" },
                    { name = "nvim_lsp" },
                    { name = "copilot" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(_, vim_item)
                            return vim_item
                        end,
                    }),
                },
            })

            cmp.setup.cmdline("/", {
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "nvim_lsp_document_symbol" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.setup.cmdline(":", {
                completion = {
                    completeopt = "menu,menuone,noselect",
                },
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = {
                                "make",
                                "Make",
                                "grep",
                                "Grep",
                                "Man",
                                "!",
                            },
                        },
                    },
                }),
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "spell" },
                }, {
                    { name = "buffer" },
                }),
            })
            cmp.setup.filetype("markdown", {
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        cmd = {
            "CopilotChat",
            "CopilotChatOpen",
            "CopilotChatClose",
            "CopilotChatToggle",
            "CopilotChatStop",
            "CopilotChatReset",
        },
        branch = "canary",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        opts = {
        },
        config = function()
            local select = require('CopilotChat.select')
            require("CopilotChat.integrations.cmp").setup()
            require('CopilotChat').setup({
                mappings = {
                    complete = {
                        insert = '',
                    },
                },
                prompts = {
                    ReviewBufferJa = {
                        prompt = 'このコードをレビューをしてください。',
                        selection = select.buffer,
                    },
                    ReviewSelectedJa = {
                        prompt = 'このコードをレビューをしてください。',
                        selection = select.visual,
                    },
                    DocsJa = {
                        prompt = '/COPILOT_GENERATE このコードを説明するドキュメントを記載してください。',
                        selection = select.visual,
                    },
                    CommitStagedJa = {
                        prompt =
                        'コミットメッセージをコミット規約に従って記述してください。タイトルは最大50文字、メッセージは最大200文字かつ72文字で折り返してください。',
                        selection = function(source)
                            return select.gitdiff(source, true)
                        end,
                    },
                },
            })
        end,
        keys = {
            {
                "<Leader>cc",
                "<Cmd>CopilotChat<CR>",
                mode = "n",
                desc = "CopilotChat Quick chat",
            },
            {
                "<Leader>cm",
                "<Cmd>CopilotChatCommitStaged<CR>",
                mode = "n",
                desc = "CopilotChat Commit staged ",
            },
            {
                "<Leader>ca",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                mode = "n",
                desc = "CopilotChat Select prompt actions",
            },
        },
    },

    {
        "garymjr/nvim-snippets",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("snippets").setup({ friendly_snippets = true })
        end,
        keys = {
            {
                "<Tab>",
                function()
                    if vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                        return
                    end
                    return "<Tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<Tab>",
                function()
                    vim.schedule(function()
                        vim.snippet.jump(1)
                    end)
                end,
                expr = true,
                silent = true,
                mode = "s",
            },
            {
                "<S-Tab>",
                function()
                    if vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                        return
                    end
                    return "<S-Tab>"
                end,
                expr = true,
                silent = true,
                mode = { "i", "s" },
            },
        },
    }
}
