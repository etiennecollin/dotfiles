return {
	"Mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	config = function() -- Set theme
		vim.cmd.colorscheme("dracula")

		-- Set transparency
		-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end,
}
