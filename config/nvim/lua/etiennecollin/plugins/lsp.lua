return {{
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
        -- Disable automatic setup, we are doing it manually
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
    end
}, {
    "williamboman/mason.nvim",
    lazy = false,
    config = true
}, -- Autocompletion
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {"hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lua", "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip",
                    "rafamadriz/friendly-snippets"},
    config = function()
        -- Here is where you configure the autocompletion settings.
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_cmp()

        -- And you can configure cmp even more, if you want to.
        local cmp = require("cmp")
        local cmp_select = {
            behavior = cmp.SelectBehavior.Select
        }
        local cmp_action = lsp_zero.cmp_action()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            sources = {{
                name = "path"
            }, {
                name = "nvim_lsp"
            }, {
                name = "nvim_lua"
            }},
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = vim.NIL, -- Disable completion with return key
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                ["<C-e>"] = cmp.mapping(cmp.mapping.close()),
                ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(cmp_behavior)),
                ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(cmp_behavior)),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({
                            select = true
                        })
                    elseif luasnip.expand_or_jumpable() then
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
                        cmp.select_next_item(cmp_behavior)
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {"i", "s"})
            })
        })

        require("luasnip").setup({
            -- Enable autotriggered snippets
            enable_autosnippets = true,
            -- Auto update fields sharing same argument
            update_events = "TextChanged,TextChangedI",
            -- Use <Tab> to trigger visual selection
            store_selection_keys = "<Tab>"
        })

        require("luasnip.loaders.from_lua").lazy_load({
            paths = "~/.config/nvim/lua/etiennecollin/snippets"
        })

    end
}, -- LSP
{
    "neovim/nvim-lspconfig",
    cmd = {"LspInfo", "LspInstall", "LspStart"},
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"hrsh7th/cmp-nvim-lsp", "williamboman/mason-lspconfig.nvim", "simrat39/rust-tools.nvim"},
    config = function()
        -- This is where all the LSP shenanigans will live
        local lsp_zero = require("lsp-zero").preset({
            suggest_lsp_servers = true,
            sign_icons = {
                error = "E",
                warn = "W",
                hint = "H",
                info = "I"
            },
            float_border = "rounded",
            call_servers = "local",
            configure_diagnostics = true,
            setup_servers_on_start = true,
            set_lsp_keymaps = {
                preserve_mappings = false,
                omit = {}
            },
            manage_nvim_cmp = {
                set_sources = "recommended",
                set_basic_mappings = true,
                set_extra_mappings = false,
                use_luasnip = true,
                set_format = true,
                documentation_window = true
            }
        })

        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
            vim.keymap.set("n", "K", function()
                vim.lsp_zero.buf.hover()
            end, {
                buffer = bufnr,
                desc = "Symbol info"
            })
            vim.keymap.set("n", "gd", function()
                vim.lsp_zero.buf.definition()
            end, {
                buffer = bufnr,
                desc = "Goto definition"
            })
            vim.keymap.set("n", "gD", function()
                vim.lsp_zero.buf.declaration()
            end, {
                buffer = bufnr,
                desc = "Goto declaration"
            })
            vim.keymap.set("n", "gi", function()
                vim.lsp_zero.buf.implementation()
            end, {
                buffer = bufnr,
                desc = "Goto implementation"
            })
            vim.keymap.set("n", "go", function()
                vim.lsp_zero.buf.type_definition()
            end, {
                buffer = bufnr,
                desc = "Goto type definition"
            })
            vim.keymap.set("n", "gr", function()
                vim.lsp_zero.buf.references()
            end, {
                buffer = bufnr,
                desc = "Goto references"
            })
            vim.keymap.set("n", "<C-k>", function()
                vim.lsp_zero.buf.signature_help()
            end, {
                buffer = bufnr,
                desc = "Symbol signature info"
            })
            vim.keymap.set("n", "<F2>", function()
                vim.lsp_zero.buf.rename()
            end, {
                buffer = bufnr,
                desc = "Refactor rename"
            })
            vim.keymap.set("n", "<F4>", function()
                vim.lsp_zero.buf.code_action()
            end, {
                buffer = bufnr,
                desc = "Code action"
            })
            vim.keymap.set("n", "gl", function()
                vim.diagnostic.open_float()
            end, {
                buffer = bufnr,
                desc = "Show diagnostics"
            })
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev()
            end, {
                buffer = bufnr,
                desc = "Previous diagnostic"
            })
            vim.keymap.set("n", "]d", function()
                vim.diagnostic.goto_next()
            end, {
                buffer = bufnr,
                desc = "Next diagnostic"
            })
        end)

        local rust_tools = require("rust-tools")
        rust_tools.setup({
            server = {
                on_attach = function(client, bufnr)
                    vim.keymap.set("n", "<leader>ca", rust_tools.hover_actions.hover_actions, {
                        buffer = bufnr,
                        desc = "Rust Tools hover actions"
                    })
                    vim.keymap.set("n", "<Leader>rc", rust_tools.code_action_group.code_action_group, {
                        buffer = bufnr,
                        desc = "Rust Tools code actions"
                    })
                end
            }
        })
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { -- Optional: List sources here, when available in mason.
            "debugpy", "java-debug-adapter", "java-test", "haskell-debug-adapter", -- DAP
            "codespell", "cpplint", "semgrep", "ruff", "vulture", "pydocstyle", "haskell-language-server", -- Linters
            "black", "latexindent", "prettier", "clang-format", "fourmolu"}, -- Formatters
            automatic_installation = false,
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    -- (Optional) Configure lua language server for neovim
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end
            }
        })
    end
}, -- DAP
{"mfussenegger/nvim-dap"}}
