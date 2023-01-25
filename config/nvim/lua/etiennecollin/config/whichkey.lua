vim.o.timeout = true
vim.o.timeoutlen = 500

local whichkey = require("which-key")

local conf = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom" -- bottom, top
    }
}

local optsT = {
    mode = "t", -- TERMINAL mode
    -- the prefix is prepended to every mapping
    prefix = ""
}

local mappingsT = {
    ["`"] = {"<cmd>ToggleTermToggleAll<cr>", "Toggle all terminals"}
}

local optsN = {
    mode = "n", -- NORMAL mode
    -- the prefix is prepended to every mapping
    prefix = "<leader>"
}

local mappingsN = {
    q = {"<cmd>q<cr>", "Quit"},
    w = {"<cmd>update!<cr>", "Save"},
    ["`"] = {"<cmd>ToggleTermToggleAll<cr>", "Toggle all terminals"},

    -- Harpoon
    a = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Add mark"},
    e = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Marks explorer"},
    h = {
        ["1"] = {"<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "Go to mark 1"},
        ["2"] = {"<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "Go to mark 2"},
        ["3"] = {"<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "Go to mark 3"},
        ["4"] = {"<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "Go to mark 4"},
        ["5"] = {"<cmd>lua require('harpoon.ui').nav_file(5)<cr>", "Go to mark 5"},
        ["6"] = {"<cmd>lua require('harpoon.ui').nav_file(6)<cr>", "Go to mark 6"},
        ["7"] = {"<cmd>lua require('harpoon.ui').nav_file(7)<cr>", "Go to mark 7"},
        ["8"] = {"<cmd>lua require('harpoon.ui').nav_file(8)<cr>", "Go to mark 8"},
        ["9"] = {"<cmd>lua require('harpoon.ui').nav_file(9)<cr>", "Go to mark 9"},
        ["0"] = {"<cmd>lua require('harpoon.ui').nav_file(10)<cr>", "Go to mark 10"}
    },

    b = {
        name = "Buffer",
        c = {"<cmd>bd!<cr>", "Close current buffer"},
        D = {"<cmd>%bd|e#|bd#<cr>", "Delete all buffers"},
        n = {"<cmd>enew<cr>", "New buffer"},
        s = {"<cmd>split<cr>", "Split buffer"},
        v = {"<cmd>vsplit<cr>", "Vsplit buffer"}
    },

    m = {
        name = "Markdown",
        c = {"<cmd>MarkdownPreviewClose<cr>", "Close preview"},
        g = {"<cmd>Glow<cr>", "Glow"},
        o = {"<cmd>MarkdownPreviewOpen<cr>", "Open preview"}
    },

    p = {
        name = "Telescope",
        b = {"<cmd>Telescope buffers<cr>", "Buffers"},
        f = {"<cmd>Telescope find_files<cr>", "Find files"},
        g = {"<cmd>Telescope git_files<cr>", "Git files"},
        h = {"<cmd>Telescope help_tags<cr>", "Help tags"},
        s = {"<cmd>Telescope live_grep<cr>", "Search"},
        S = {"<cmd>Telescope grep_string<cr>", "Search word"},
        t = {"<cmd>Telescope treesitter<cr>", "Treesitter"},
        T = {"<cmd>Telescope tags<cr>", "Tags"},
        v = {"<cmd>Ex<cr>", "Browser"}
    },

    t = {
        name = "Terminal",
        f = {"<cmd>ToggleTerm direction=float<cr>", "Float"},
        h = {"<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal"},
        t = {"<cmd>ToggleTerm direction=tab<cr>", "Tab"},
        v = {"<cmd>ToggleTerm direction=vertical<cr>", "Vertical"}
    },

    z = {
        name = "Packer",
        c = {"<cmd>PackerClean<cr>", "Clean"},
        C = {"<cmd>PackerCompile<cr>", "Compile"},
        i = {"<cmd>PackerInstall<cr>", "Install"},
        s = {"<cmd>PackerSync<cr>", "Sync"},
        S = {"<cmd>PackerStatus<cr>", "Status"},
        u = {"<cmd>PackerUpdate<cr>", "Update"}

    }
}

whichkey.setup(conf)
whichkey.register(mappingsN, optsN)
whichkey.register(mappingsT, optsT)
