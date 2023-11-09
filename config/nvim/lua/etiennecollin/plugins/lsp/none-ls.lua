return {
    "nvimtools/none-ls.nvim", -- configure formatters & linters
    lazy = true,
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"williamboman/mason.nvim", "jay-babu/mason-null-ls.nvim"},
    config = function()
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")

        local lsp_formatting = function(bufnr)
            vim.lsp.buf.format({
                filter = function(client)
                    return client.name == "null-ls"
                end,
                bufnr = bufnr
            })
        end

        -- Formatting on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            lsp_formatting(bufnr)
                        end
                    })
                end
            end
        })

        require("mason-null-ls").setup({
            handlers = {}
            -- ensure_installed = {},
            -- automatic_installation = false
        })
    end
}
