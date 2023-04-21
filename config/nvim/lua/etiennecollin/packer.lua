-- Shortcut to get the config file of a plugin
-- function get_config(fileName)
--   return function()
--     require("etiennecollin/config/" .. fileName)
--   end
-- end
-----------------------------
-----------------------------
-- Packer setup vs config:
-- setup: run before the plugin is loaded
-- config: run after the plugin is loaded
-----------------------------
-----------------------------
function get_config(fileName)
    return string.format("require('etiennecollin.config.%s')", fileName)
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -- Required by null-ls and used by other plugins
    use("nvim-lua/plenary.nvim")

    -------------------------
    -------------------------
    -- Theme & Customization
    -------------------------
    -------------------------

    -- Color theme
    use({
        "Mofiqul/dracula.nvim",
        as = "dracula",
        config = get_config("dracula")
    })

    -- File explorer
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        tag = "nightly", -- optional, updated every week. (see issue #1193)
        config = get_config("nvimtree")
    }

    -- Tabs bar
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = get_config("bufferline")
    }

    -- Status bar
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        },
        config = get_config("lualine")
    }

    -------------------------
    -------------------------
    -- File management
    -------------------------
    -------------------------

    -- File browser
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        -- or                            , branch = "0.1.x",
        requires = {{"nvim-lua/plenary.nvim"}}
    })

    -- Better file navigation and adds marks
    use("theprimeagen/harpoon")

    -- Ultimate undo tree
    use("mbbill/undotree")

    -------------------------
    -------------------------
    -- Language support
    -------------------------
    -------------------------

    -- List of diagnostics and other LSP stuff
    use({
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = get_config("trouble")
    })

    -- Syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {{"nvim-treesitter/nvim-treesitter-context"}},
        config = get_config("treesitter"),
        run = ":TSUpdate"
    })

    -- Setup LSP
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = { -- LSP Support
        {"neovim/nvim-lspconfig"}, -- Required
        {"williamboman/mason.nvim"}, -- Optional
        {"williamboman/mason-lspconfig.nvim"}, -- Optional
        -- Autocompletion
        {"hrsh7th/nvim-cmp"}, -- Required
        {"hrsh7th/cmp-nvim-lsp"}, -- Required
        -- {"hrsh7th/cmp-buffer"}, -- Optional
        {"hrsh7th/cmp-path"}, -- Optional
        {"saadparwaiz1/cmp_luasnip"}, -- Optional
        {"hrsh7th/cmp-nvim-lua"}, -- Optional
        -- Snippets
        {"L3MON4D3/LuaSnip"}, -- Required
        {"rafamadriz/friendly-snippets"}, -- Optional
        -- Handle Rust language server
        {"simrat39/rust-tools.nvim"}, -- Required for rust_analyzer
        -- DAP
        {"mfussenegger/nvim-dap"}, -- Optional
        -- Linter and Formatter
        {"jose-elias-alvarez/null-ls.nvim"}, -- Required
        {"jay-babu/mason-null-ls.nvim"} -- Required to link null-ls to mason
        },
        config = get_config("lsp")
    })

    -- LaTeX support
    use({
        "lervag/vimtex",
        config = get_config("vimtex")
    })

    -------------------------
    -------------------------
    -- Other Plugins
    -------------------------
    -------------------------

    -- Markdown quick preview
    use({
        "ellisonleao/glow.nvim",
        config = get_config("glow")
    })

    -- Markdown complete preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
        setup = get_config("markdownpreview")
    })

    -- Terminal inside neovim
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = get_config("toggleterm")
    })

    -- Git integration
    use("tpope/vim-fugitive")

    -- Easy commenting
    use({
        "preservim/nerdcommenter",
        setup = get_config("nerdcommenter")
    })

    -------------------------
    -------------------------
    -- Bindings
    -------------------------
    -------------------------

    use({
        "folke/which-key.nvim",
        config = get_config("whichkey")
    })

end)
