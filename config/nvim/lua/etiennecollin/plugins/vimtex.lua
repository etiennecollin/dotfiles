return {
	"lervag/vimtex",
	config = function()
		vim.g.tex_flavor = "latex"

		-- Viewer
		vim.g.vimtex_view_method = "skim" -- skim or zathura

		-- To setup for skim, uncomment the following 3 lines
		vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
		vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given

		vim.g.vimtex_quickfix_mode = 0
		vim.opt.conceallevel = 0
		-- vim.g.tex_conceal = "abdmg"
	end,
}
