return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-path", -- Source for completion of paths
		"hrsh7th/cmp-buffer", -- Source for completion of words in buffers
		"hrsh7th/cmp-cmdline", -- Source for commandline completion
		"hrsh7th/cmp-nvim-lua", -- Source for completion of Neovim's Lua API
		"hrsh7th/cmp-nvim-lsp-signature-help", -- Source for function signature
		"github/copilot.vim",
		"zbirenbaum/copilot-cmp", -- Source for copilot
		"L3MON4D3/LuaSnip", -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- Source for completion of LuaSnip snippets
		"rafamadriz/friendly-snippets", -- Collection of useful snippets
		"onsails/lspkind.nvim", -- Pictograms in completion menu
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("copilot_cmp").setup()

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		luasnip.setup({
			-- Enable autotriggered snippets
			enable_autosnippets = true,
			-- Auto update fields sharing same argument
			update_events = "TextChanged,TextChangedI",
			-- Use <Tab> to trigger visual selection
			store_selection_keys = "<Tab>",
		})

		-- Loads snippets from friendly-snippets and custom snippets
		require("luasnip.loaders.from_lua").lazy_load({
			paths = "~/.config/nvim/lua/etiennecollin/snippets",
		})
		require("luasnip.loaders.from_vscode").lazy_load()

		local has_words_before = function()
			--     unpack = unpack or table.unpack
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		end

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect,noinsert",
			},

			-- Configure how nvim-cmp interacts with luasnip
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			sources = cmp.config.sources({
				-- {
				--     name = "copilot", -- Copilot
				-- },
				{
					name = "nvim_lsp", -- LSP
				},
				{
					name = "nvim_lsp_signature_help", -- Complete function info
				},
				{
					name = "luasnip", -- Snippets
				},
				{
					name = "buffer", -- Text within current buffer
				},
				{
					name = "nvim_lua", -- Neovim Lua API
				},
				{
					name = "path", -- File paths
				},
			}),

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			-- Set formatting of completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = 50,
					ellipsis_char = "...",
					symbol_map = { Copilot = "" },
				}),
			},

			mapping = cmp.mapping.preset.insert({
				-- ["<CR>"] = vim.NIL, -- Disable completion with return key
				["<CR>"] = cmp.mapping.confirm({
					select = false,
				}),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<Tab>"] = cmp.mapping(function(fallback)
					if require("copilot.suggestion").is_visible() then
						require("copilot.suggestion").accept()
					elseif cmp.visible() then
						cmp.confirm({
							select = true,
						})
					elseif luasnip.expand_or_locally_jumpable() then
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})

		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		cmp.event:on("menu_opened", function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on("menu_closed", function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end,
}
