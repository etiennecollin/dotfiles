--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- LSP-ZERO --------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
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

-- CMP setup -------------
local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_behavior = {
    behavior = cmp.SelectBehavior.Select
}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<cr>"] = nil, -- Disable completion with return key
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

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, {
        buffer = bufnr,
        desc = "Symbol info"
    })
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, {
        buffer = bufnr,
        desc = "Goto definition"
    })
    vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
    end, {
        buffer = bufnr,
        desc = "Goto declaration"
    })
    vim.keymap.set("n", "gi", function()
        vim.lsp.buf.implementation()
    end, {
        buffer = bufnr,
        desc = "Goto implementation"
    })
    vim.keymap.set("n", "go", function()
        vim.lsp.buf.type_definition()
    end, {
        buffer = bufnr,
        desc = "Goto type definition"
    })
    vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
    end, {
        buffer = bufnr,
        desc = "Goto references"
    })
    vim.keymap.set("n", "<C-k>", function()
        vim.lsp.buf.signature_help()
    end, {
        buffer = bufnr,
        desc = "Symbol signature info"
    })
    vim.keymap.set("n", "<F2>", function()
        vim.lsp.buf.rename()
    end, {
        buffer = bufnr,
        desc = "Refactor rename"
    })
    vim.keymap.set("n", "<F4>", function()
        vim.lsp.buf.code_action()
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

lsp.nvim_workspace() -- (Optional) Configure lua language server for nvim
lsp.setup()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Rust Analyzer ---------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Null-LS ---------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- LuaSnip ---------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

require("luasnip").setup({
    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Auto update fields sharing same argument
    update_events = "TextChanged,TextChangedI"
})

require("luasnip.loaders.from_lua").lazy_load({
    paths = "~/.config/nvim/lua/etiennecollin/snippets"
})
