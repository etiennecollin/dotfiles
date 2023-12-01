local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		import = "etiennecollin.plugins",
	},
	{
		import = "etiennecollin.plugins.lsp",
	},
	{
		import = "etiennecollin.plugins.themes",
	},
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

vim.cmd.colorscheme("tokyonight-night")

-- Set transparency
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
