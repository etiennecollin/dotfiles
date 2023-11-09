return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"folke/neodev.nvim", "hrsh7th/cmp-nvim-lsp", "williamboman/mason.nvim",
                    "williamboman/mason-lspconfig.nvim", "simrat39/rust-tools.nvim"},
    config = function()
        require("neodev").setup({})
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = {
            noremap = true,
            silent = true
        }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- Show definition, references
            opts.desc = "Show LSP references"
            vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            -- Go to declaration
            opts.desc = "Go to declaration"
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            -- Show lsp definitions
            opts.desc = "Show LSP definitions"
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            -- Show lsp implementations
            opts.desc = "Show LSP implementations"
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            -- Show lsp type definitions
            opts.desc = "Show LSP type definitions"
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            -- See available code actions, in visual mode will apply to selection
            opts.desc = "See available code actions"
            vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

            -- Smart rename
            opts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- Show  diagnostics for file
            opts.desc = "Show buffer diagnostics"
            vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            -- Show diagnostics for line
            opts.desc = "Show line diagnostics"
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            -- Jump to previous diagnostic in buffer
            opts.desc = "Go to previous diagnostic"
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            -- Jump to next diagnostic in buffer
            opts.desc = "Go to next diagnostic"
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            -- Show documentation for what is under cursor
            opts.desc = "Show documentation for what is under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- Mapping to restart lsp if necessary
            opts.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.default_capabilities()

        require("mason-lspconfig").setup({
            -- ensure_installed = {"debugpy", "java-debug-adapter", "java-test", "haskell-debug-adapter", -- DAP
            -- "codespell", "cpplint", "semgrep", "ruff", "vulture", "pydocstyle", "haskell-language-server", -- Linters
            -- "black", "latexindent", "prettier", "clang-format", "fourmolu"}, -- Formatters
            -- automatic_installation = false
        })

        local default_handler = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach
            }
        end

        local rust_handler = function()
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
                },
                capabilities = capabilities
            })
        end

        require("mason-lspconfig").setup_handlers({
            default_handler,
            -- Specific servers
            ["rust_analyzer"] = rust_handler
        })

        -- Set diagnostic symbols
        local signs = {
            Error = " ",
            Warn = " ",
            Hint = "󰠠 ",
            Info = " "
        }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
                text = icon,
                texthl = hl,
                numhl = ""
            })
        end
    end
}
