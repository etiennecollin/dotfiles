vim.o.timeout = true
vim.o.timeoutlen = 300

local whichkey = require("which-key")

local conf = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom" -- bottom, top
    }
}

local opts = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local mappings = {
    q = {"<cmd>q!<cR>", "Quit"},
    w = {"<cmd>update!<cR>", "Save"},

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
        o = {"<cmd>MarkdownPreviewOpen<cr>", "Open preview"},
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

    z = {
        name = "Packer",
        c = {"<cmd>PackerCompile<cr>", "Compile"},
        C = {"<cmd>PackerClean<cr>", "Clean"},
        i = {"<cmd>PackerInstall<cr>", "Install"},
        s = {"<cmd>PackerSync<cr>", "Sync"},
        S = {"<cmd>PackerStatus<cr>", "Status"},
        u = {"<cmd>PackerUpdate<cr>", "Update"},

    },
    -- g = {
    --     name = "Git",
    --     s = {"<cmd>Neogit<CR>", "Status"}
    -- }
}

whichkey.setup(conf)
whichkey.register(mappings, opts)
