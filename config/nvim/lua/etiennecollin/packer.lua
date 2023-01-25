-- Shortcut to get the config file of a plugin
-- function get_config(fileName)
--   return function()
--     require("etiennecollin/config/" .. fileName)
--   end
-- end
function get_config(fileName)
    return string.format('require("etiennecollin/config/%s")', fileName)
end


-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Color theme
    use({
        "Mofiqul/dracula.nvim",
        as = "dracula",
        config = get_config("dracula")
    })

    -- File browser
    use({
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        -- or                            , branch = "0.1.x",
        requires = { {"nvim-lua/plenary.nvim"} }
    })

    -- Syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        config = get_config("treesitter"),
        run = ":TSUpdate"
    })

    -- Setup LSP
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {"williamboman/mason.nvim"},           -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},         -- Required
            {"hrsh7th/cmp-nvim-lsp"},     -- Required
            {"hrsh7th/cmp-buffer"},       -- Optional
            {"hrsh7th/cmp-path"},         -- Optional
            {"saadparwaiz1/cmp_luasnip"}, -- Optional
            {"hrsh7th/cmp-nvim-lua"},     -- Optional

            -- Snippets
            {"L3MON4D3/LuaSnip"},             -- Required
            {"rafamadriz/friendly-snippets"}, -- Optional
        },
        config = get_config("lsp")
    })

    -- Better file navigation and adds marks
    use({
        "theprimeagen/harpoon",
        config = get_config("harpoon")
    })

    use({
        "folke/which-key.nvim",
        config = get_config("whichkey")
    })

    -- Handle Rust language server
    use("simrat39/rust-tools.nvim")

    -- LaTeX support
    use({
        "lervag/vimtex",
        config = get_config("vimtex")
    })

    -- Markdown
    -- Quick preview
    use({
        "ellisonleao/glow.nvim",
        config = get_config("glow")
    })
    -- Complete preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        setup = get_config("markdownpreview")
    })
end)
