return {
	"michaelb/sniprun",
	branch = "master",
	cmd = "SnipRun",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			--# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
			--# to filter only successful runs (or errored-out runs respectively)
			display = {
				"Classic", --# display results in the command-line  area
				"VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
				-- "VirtualText",             --# display results as virtual text
				-- "TempFloatingWindow",      --# display results in a floating window
				-- "LongTempFloatingWindow", --# display results in a floating window, but only long results. To use with VirtualText[Ok/Err]
				-- "Terminal",                --# display results in a vertical split
				-- "TerminalWithCode",        --# display results and code history in a vertical split
				-- "NvimNotify",              --# display with the nvim-notify plugin
				-- "Api"                      --# return output to a programming interface
			},

			live_display = { "VirtualTextOk" }, --# display mode used in live_mode

			display_options = {
				terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
				terminal_line_number = false, --# whether show line number in terminal window
				terminal_signcolumn = false, --# whether show signcolumn in terminal window
				terminal_persistence = true, --# always keep the terminal open (true) or close it at every occasion (false)
				terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
				terminal_width = 45, --# change the terminal display option width (if vertical)
				terminal_height = 20, --# change the terminal display option height (if horizontal)
				notification_timeout = 5, --# timeout for nvim_notify output
			},

			--# You can use the same keys to customize whether a sniprun producing
			--# no output should display nothing or '(no output)'
			show_no_output = {
				"Classic",
				"TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
			},

			live_mode_toggle = "off", --# live mode toggle, see Usage - Running for more info

			borders = "single", --# display borders around floating windows
			--# possible values are 'none', 'single', 'double', or 'shadow'
		})

		vim.api.nvim_set_keymap("v", "<leader>rr", "<Plug>SnipRun", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ro", "<Plug>SnipRunOperator", { silent = true })
		vim.api.nvim_set_keymap("n", "<leader>rr", "<Plug>SnipRun", { silent = true })
	end,
}
