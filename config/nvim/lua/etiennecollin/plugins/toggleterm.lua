return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = "ToggleTerm",
	config = true,
	init = function()
		vim.keymap.set({ "n", "i", "v", "t" }, "<S-F1>", "<cmd>ToggleTermToggleAll<cr>", {
			desc = "Toggle terminals",
		})
	end,
}
