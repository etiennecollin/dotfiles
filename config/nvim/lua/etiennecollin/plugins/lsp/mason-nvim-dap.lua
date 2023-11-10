return {
    "jay-babu/mason-nvim-dap.nvim",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
        -- Install DAPs with mason
        require("mason-nvim-dap").setup({
            ensure_installed = {"codelldb"},
            automatic_installation = true,
            automatic_setup = true,
            handlers = {}
        })

    end
}
