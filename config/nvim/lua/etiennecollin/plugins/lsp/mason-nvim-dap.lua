return {
	"jay-babu/mason-nvim-dap.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
	opts = {
		ensure_installed = { "codelldb" },
		automatic_installation = true,
		automatic_setup = true,
		handlers = {},
	},
}
