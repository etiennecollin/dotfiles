vim.o.timeout = true
vim.o.timeoutlen = 500

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
    a = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Marks explorer"},

    A = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "Add mark"},

    b = {
        name = "Buffer",
        D = {"<cmd>%bd|e#|bd#<cr>", "Delete all buffers"},
        f = {"<cmd>BufferLinePick<cr>", "Pick buffer"},
        F = {"<cmd>BufferLinePickClose<cr>", "Pick buffer to close"},
        -- h = {"<cmd>split<cr>", "Hsplit window"},
        n = {"<cmd>enew<cr>", "New buffer"},
        p = {"<cmd>BufferLineTogglePin<cr>", "Toggle buffer pin"},
        -- v = {"<cmd>vsplit<cr>", "Vsplit window"}
    },

    c = {"<plug>NERDCommenterToggle", "Toggle commenting"},

    C = {
        name = "Commenting",
        a = {"<plug>NERDCommenterAltDelims", "Alternative"},
        m = {"<plug>NERDCommenterMinimal", "Minimal"},
        s = {"<plug>NERDCommenterSexy", "Pretty"}
    },

    d = {
        name = "NvimTree",
        s = {"<cmd>NvimTreeFindFile<cr>", "Find file"},
        c = {"<cmd>NvimTreeCollapseKeepBuffers<cr>", "Collapse"}
    },

    e = {"<cmd>NvimTreeFocus<cr>", "Open file explorer"},

    f = {"<cmd>LspZeroFormat<cr>", "Format file"},

    g = {"<cmd>Git<cr>", "Git status"},

    h = {"<cmd>BufferLineCyclePrev<cr>", "Buffer cycle prev"},
    H = {"<cmd>BufferLineMovePrev<cr>", "Buffer move prev"},

    l = {"<cmd>BufferLineCycleNext<cr>", "Buffer cycle next"},
    L = {"<cmd>BufferLineMoveNext<cr>", "Buffer move next"},

    m = {
        name = "Markdown",
        g = {"<cmd>Glow<cr>", "Glow"},
        s = {"<cmd>MarkdownPreview<cr>", "Start preview"},
        S = {"<cmd>MarkdownPreviewStop<cr>", "Stop preview"}
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

    q = {"<cmd>bd!<cr>", "Close buffer"},
    Q = {"<cmd>q!<cr>", "Quit"},

    s = {":%s//gI<Left><Left><Left>", "Replace all"},
    S = {":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace word"},

    t = {
        name = "Terminal",
        f = {"<cmd>ToggleTerm direction=float<cr>", "Float"},
        h = {"<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal"},
        t = {"<cmd>ToggleTerm direction=tab<cr>", "Tab"},
        v = {"<cmd>ToggleTerm direction=vertical<cr>", "Vertical"}
    },

    u = {"<cmd>UndotreeToggle<cr>", "Undotree"},

    w = {"<cmd>update!<cr>", "Save"},
    W = {"<cmd>w !sudo tee > /dev/null %<cr>", "Sudo save"},

    x = {"<cmd>!chmod +x %", "Make executable"},

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
whichkey.register(mappings, opts)
