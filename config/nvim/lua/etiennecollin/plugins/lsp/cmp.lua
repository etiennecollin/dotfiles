return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {"hrsh7th/cmp-path", -- Source for completion of paths
    "hrsh7th/cmp-buffer", -- Source for completion of words in buffers
    "hrsh7th/cmp-nvim-lua", -- Source for completion of Neovim's Lua API
    "hrsh7th/cmp-nvim-lsp-signature-help", -- Source for function signature
    "L3MON4D3/LuaSnip", -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- Source for completion of LuaSnip snippets
    "rafamadriz/friendly-snippets", -- Collection of useful snippets
    "onsails/lspkind.nvim" -- Pictograms in completion menu
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        luasnip.setup({
            -- Enable autotriggered snippets
            enable_autosnippets = true,
            -- Auto update fields sharing same argument
            update_events = "TextChanged,TextChangedI",
            -- Use <Tab> to trigger visual selection
            store_selection_keys = "<Tab>"
        })

        -- Loads snippets from friendly-snippets and custom snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
            paths = "~/.config/nvim/lua/etiennecollin/snippets"
        })

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect,noinsert"
            },

            -- Configure how nvim-cmp interacts with luasnip
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

            sources = cmp.config.sources({{
                name = "nvim_lsp" -- LSP
            }, {
                name = "nvim_lsp_signature_help" -- Complete function info
            }, {
                name = "luasnip" -- Snippets
            }, {
                name = "buffer" -- Text within current buffer
            }, {
                name = "nvim_lua" -- Neovim Lua API
            }, {
                name = "path" -- File paths
            }}),

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },

            -- Set formatting of completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "..."
                })
            },

            mapping = cmp.mapping.preset.insert({
                -- ["<CR>"] = vim.NIL, -- Disable completion with return key
                ["<CR>"] = cmp.mapping.confirm({
                    select = false
                }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({
                            select = true
                        })
                    elseif luasnip.expand_or_locally_jumpable() then
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            })
        })
    end
}
