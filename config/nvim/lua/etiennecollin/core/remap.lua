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

-- Apparently the greatest remaps ever
vim.keymap.set("x", "<leader>p", [["_dP]], {
	desc = "Delete and paste (keep clipboard)",
})
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], {
	desc = "Yank selection to system clipboard",
})
vim.keymap.set("n", "<leader>Y", [["+Y]], {
	desc = "Yank whole line to system clipboard",
})
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], {
	desc = "Delete without yank",
})

-- I'll get cancelled too...
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Insert mode escape" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {
	desc = "Navigate window left",
})
vim.keymap.set("n", "<C-j>", "<C-w>j", {
	desc = "Navigate window down",
})
vim.keymap.set("n", "<C-k>", "<C-w>k", {
	desc = "Navigate window up",
})
vim.keymap.set("n", "<C-l>", "<C-w>l", {
	desc = "Navigate window right",
})

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Fighting one-eyed kirby
vim.keymap.set(
	"v",
	"<leader>k",
	":s/\\(\\S.*\\)/ \\1/g<left><left><left><left><left>",
	{ desc = "Fighting one-eyed kirby" }
)

-- Exit insert mode
vim.keymap.set("i", "jk", "<esc>", {
	desc = "Exit insert mode",
})
