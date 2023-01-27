function setTheme(theme)
    -- Set theme
    theme = theme or "dracula"
    vim.cmd.colorscheme(theme)

    -- Set transparency
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

setTheme()