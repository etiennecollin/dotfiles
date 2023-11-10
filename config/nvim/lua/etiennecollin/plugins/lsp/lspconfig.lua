return {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"folke/neodev.nvim", "hrsh7th/cmp-nvim-lsp", "williamboman/mason.nvim",
                    "williamboman/mason-lspconfig.nvim", "mfussenegger/nvim-dap", "akinsho/toggleterm.nvim",
                    "simrat39/rust-tools.nvim"},
    config = function()
        require("neodev").setup({
            library = {
                plugins = {"nvim-dap-ui"},
                types = true
            }
        })

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Install LSPs with mason
        require("mason-lspconfig").setup({
            ensure_installed = {"rust_analyzer"},
            automatic_installation = true
        })

        -- Setup lspconfig
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

        local default_handler = function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach
            }
        end

        -- Setup for rust-analyzer
        local rust_handler = function()
            -- Setup codelldb path for DAP
            local extension_path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
            if not vim.fn.filereadable(codelldb_path) or not vim.fn.filereadable(liblldb_path) then
                local msg =
                    "Installing codelldb via Mason...\nEither codelldb or liblldb was not readable.\ncodelldb: " ..
                        codelldb_path .. "\nliblldb: " .. liblldb_path
                vim.notify(msg, vim.log.levels.INFO)
                vim.cmd(":MasonInstall codelldb")
            end

            local rust_tools = require("rust-tools")
            rust_tools.setup({
                tools = {
                    reload_workspace_from_cargo_toml = true,
                    executor = require("rust-tools.executors").toggleterm,
                    hover_actions = {
                        auto_focus = true
                    },
                    inlay_hints = {
                        auto = true,
                        parameter_hints_prefix = "<-",
                        other_hints_prefix = "->"
                    }
                },
                dap = {
                    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
                },
                server = {
                    standalone = false,
                    on_attach = function(client, bufnr)
                        on_attach(client, bufnr)

                        vim.keymap.set("n", "<leader>ca", rust_tools.hover_actions.hover_actions, {
                            buffer = bufnr,
                            desc = "Rust Tools hover actions"
                        })
                        vim.keymap.set("n", "<Leader>rc", rust_tools.code_action_group.code_action_group, {
                            buffer = bufnr,
                            desc = "Rust Tools code actions"
                        })
                    end,
                    settings = {
                        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                                extraArgs = {"--all", "--", "-W", "clippy::all"}
                            },
                            checkOnSave = {
                                command = "clippy"
                            },
                            inlayHints = {
                                chainingHints = {
                                    enable = false
                                },
                                closingBraceHints = {
                                    enable = false
                                }
                            }
                        }
                    }
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
            Hint = " ",
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

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = true,
            underline = true,
            severity_sort = false,
            float = {
                border = "rounded",
                source = "always",
                header = "",
                prefix = ""
            }
        })
    end
}
