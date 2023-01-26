-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- LSP-ZERO -------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed({"rust_analyzer", "sumneko_lua"})
-- Don't initialize this language server we will use rust-tools to setup rust_analyzer
lsp.skip_server_setup({'rust_analyzer'})
lsp.set_preferences({ -- See :help lsp-zero-preferences
    set_lsp_keymaps = true, -- set to false if you want to configure your own keybindings
    manage_nvim_cmp = true, -- set to false if you want to configure nvim-cmp on your own
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I"
    }
})

-- local cmp = require("cmp")
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--   ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--   ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--   ["<C-y>"] = cmp.mapping.confirm({ select = true }),
--   ["<C-Space>"] = cmp.mapping.complete(),
-- })
-- -- disable completion with tab
-- -- this helps with copilot setup
-- cmp_mappings["<Tab>"] = nil
-- cmp_mappings["<S-Tab>"] = nil
-- lsp.setup_nvim_cmp({
--   mapping = cmp_mappings
-- })

lsp.on_attach(function(client, bufnr)
    local opts = {
        buffer = bufnr,
        remap = false
    }
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)
lsp.nvim_workspace() -- (Optional) Configure lua language server for nvim
lsp.setup()

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Rust Analyzer --------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Initialize rust_analyzer with rust-tools
-- see :help lsp-zero.build_options()
local rust_lsp = lsp.build_options('rust_analyzer', {
    single_file_support = false,
    on_attach = function(client, bufnr)
        print('hello rust-tools')
    end
})

require('rust-tools').setup({
    server = rust_lsp
})

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Null-LS --------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

require("mason").setup()
require("mason-null-ls").setup({
    ensure_installed = {
        -- Optional: List sources here, when available in mason.
    },
    automatic_installation = false,
    automatic_setup = true -- Setup Mason handlers in null-ls.
})
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})
require'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
