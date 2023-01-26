vim.g.mapleader = " "

-- Example remap such that they appear in whichkey
-- vim.keymap.set("n", "gq", "<cmd>lua vim.lsp.buf.formatting()<CR>", {
--     desc = "format document [LSP]"
-- })
vim.keymap.set({"n", "i", "t"}, "<F2>", "<cmd>ToggleTermToggleAll<cr>", {
    desc = "Toggle all terminals"
})
