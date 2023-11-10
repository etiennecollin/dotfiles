return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "neovim/nvim-lspconfig" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			diagnostics = "nvim_lsp",
		},
	},
}
