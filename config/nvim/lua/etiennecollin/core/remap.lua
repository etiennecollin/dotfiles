vim.g.mapleader = " "

-- Move up/down selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join current line with line below and replace
-- cursor at initial position
vim.keymap.set("n", "J", "mzJ`z")

-- Up/down half page with centered view
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search next/previous with centered view
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Apparently the greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
    desc = "Navigate window left"
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
    desc = "Navigate down"
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
    desc = "Navigate up"
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
    desc = "Navigate right"
})

-- Terminal
vim.keymap.set({"n", "i", "v", "t"}, "<S-F1>", "<cmd>ToggleTermToggleAll<cr>", {
    desc = "Toggle terminals"
})

-- Commenting
vim.keymap.set("v", "<leader>cc", "<plug>NERDCommenterToggle", {
    desc = "Toggle commenting"
})

-- Exit insert mode
vim.keymap.set("i", "jk", "<esc>", {
    desc = "Exit insert mode"
})
