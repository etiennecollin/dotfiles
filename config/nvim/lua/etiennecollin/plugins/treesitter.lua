return {{
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = function()
        require("nvim-treesitter.install").update({
            with_sync = true
        })()
    end,
    event = {"VeryLazy"},
    init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
    end,
    cmd = {"TSUpdateSync", "TSUpdate", "TSInstall"},
    opts = {
        ensure_installed = {"java", "markdown", "markdown_inline", "rust", "python", "lua", "comment"},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
            enable = true,
            disable = {"latex"},
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false
        },

        indent = {
            enable = true
        }
    }
}, {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    enabled = true,
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    opts = {
        mode = "cursor",
        max_lines = 3
    }
}}
