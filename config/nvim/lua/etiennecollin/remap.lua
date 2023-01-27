vim.g.mapleader = " "

-- Window navigation
vim.keymap.set({"n"}, "<C-h>", "<C-w>h", {
    desc = "Navigate window left"
})
vim.keymap.set({"n"}, "<C-j>", "<C-w>j", {
    desc = "Navigate down"
})
vim.keymap.set({"n"}, "<C-k>", "<C-w>k", {
    desc = "Navigate up"
})
vim.keymap.set({"n"}, "<C-l>", "<C-w>l", {
    desc = "Navigate right"
})

-- Terminal
-- F14 = Shift + F1
vim.keymap.set({"n", "i", "v", "t"}, "<F14>", "<cmd>ToggleTermToggleAll<cr>", {
    desc = "Toggle terminals"
})

-- Commenting
vim.keymap.set({"v"}, "<C-/>", "<plug>NERDCommenterToggle", {
    desc = "Toggle commenting"
})

-- Exit insert mode
vim.keymap.set({"i"}, "jk", "<esc>", {
    desc = "Exit insert mode"
})
