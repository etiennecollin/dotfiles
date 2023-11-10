return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    config = function()
        local whichkey = require("which-key")

        local conf = {
            window = {
                border = "single", -- none, single, double, shadow
                position = "bottom" -- bottom, top
            }
        }

        local opts = {
            mode = "n", -- NORMAL mode
            -- the prefix is prepended to every mapping
            prefix = "<leader>"
        }

        local mappings = {
            a = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon"},
            A = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Add to Harpoon"},

            b = {
                name = "Buffer",
                D = {"<cmd>%bd|e#|bd#<cr>", "Delete all buffers"},
                f = {"<cmd>BufferLinePick<cr>", "Pick buffer"},
                F = {"<cmd>BufferLinePickClose<cr>", "Pick buffer to close"},
                h = {"<cmd>split<cr>", "Hsplit window"},
                n = {"<cmd>enew<cr>", "New buffer"},
                p = {"<cmd>BufferLineTogglePin<cr>", "Toggle buffer pin"},
                v = {"<cmd>vsplit<cr>", "Vsplit window"}
            },

            c = {
                name = "Commenting",
                t = {"<plug>NERDCommenterAltDelims", "Alternative"},
                c = {"<plug>NERDCommenterToggle", "Toggle commenting"},
                m = {"<plug>NERDCommenterMinimal", "Minimal"},
                s = {"<plug>NERDCommenterSexy", "Pretty"}
            },

            d = {
                name = "Debug"
            },

            e = {"<cmd>NvimTreeToggle<cr>", "Toggle file explorer"},
            E = {
                name = "NvimTree",
                E = {"<cmd>NvimTreeClose<cr>", "Close file explorer"},
                F = {"<cmd>NvimTreeFindFile<cr>", "Find file"},
                C = {"<cmd>NvimTreeCollapseKeepBuffers<cr>", "Collapse unused dirs"}
            },

            f = {"<cmd>lua vim.lsp.buf.format()<cr>", "Format file"},

            h = {"<cmd>BufferLineCyclePrev<cr>", "Buffer cycle prev"},
            H = {"<cmd>BufferLineMovePrev<cr>", "Buffer move prev"},

            l = {"<cmd>BufferLineCycleNext<cr>", "Buffer cycle next"},
            L = {"<cmd>BufferLineMoveNext<cr>", "Buffer move next"},

            m = {"<cmd>MarkdownPreviewToggle<cr>", "Toggle markdown preview"},

            p = {
                name = "Telescope",
                b = {"<cmd>Telescope buffers<cr>", "Buffers"},
                f = {"<cmd>Telescope find_files<cr>", "Files"},
                g = {"<cmd>Telescope git_files<cr>", "Git files"},
                h = {"<cmd>Telescope help_tags<cr>", "Help tags"},
                r = {"<cmd>Telescope oldfiles<cr>", "Recent files"},
                s = {"<cmd>Telescope live_grep<cr>", "Search"},
                S = {"<cmd>Telescope grep_string<cr>", "Search word"},
                t = {"<cmd>Telescope treesitter<cr>", "Treesitter"},
                T = {"<cmd>Telescope tags<cr>", "Tags"}
            },

            q = {"<cmd>bd<cr>", "Close buffer"},
            Q = {"<cmd>q<cr>", "Quit"},

            s = {":%s//gI<Left><Left><Left>", "Replace all"},
            S = {":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace word"},

            t = {
                name = "Terminal",
                f = {"<cmd>ToggleTerm direction=float<cr>", "Float"},
                h = {"<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal"},
                t = {"<cmd>ToggleTerm direction=tab<cr>", "Tab"}
            },

            u = {"<cmd>UndotreeToggle<cr>", "Undotree"},

            w = {"<cmd>update!<cr>", "Save"},

            x = {
                name = "Trouble",
                x = {"<cmd>TroubleToggle<cr>", "Toggle trouble"},
                w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics"},
                d = {"<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics"},
                q = {"<cmd>TroubleToggle quickfix<cr>", "Quickfix"},
                l = {"<cmd>TroubleToggle loclist<cr>", "Loclist"}
            },
            X = {"<cmd>!chmod +x %", "Make executable"},

            z = {
                name = "Lazy/Mason",
                m = {"<cmd>Mason<cr>", "Mason"},
                l = {"<cmd>Lazy<cr>", "Lazy"}
            }
        }

        whichkey.setup(conf)
        whichkey.register(mappings, opts)
    end
}
