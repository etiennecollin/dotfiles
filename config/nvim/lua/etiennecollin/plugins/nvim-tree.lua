return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        -- Disable netrw at the very start (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            sort_by = "name",
            view = {
                adaptive_size = true,
                relativenumber = true
                -- mappings = {
                --     list = {{
                --         key = "u",
                --         action = "dir_up"
                --     }}
                -- }
            },
            renderer = {
                indent_markers = {
                    enable = true
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "", -- arrow when folder is closed
                            arrow_open = "" -- arrow when folder is open
                        }
                    }
                },
                group_empty = true
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false
                    }
                }
            },
            filters = {
                dotfiles = true,
                custom = {".DS_Store"}
            },
            git = {
                ignore = false
            }
        })

        -- Launch nvim-tree on startup for directories and [No Name] buffers
        local function open_nvim_tree(data)

            -- Buffer is a real file on the disk
            local real_file = vim.fn.filereadable(data.file) == 1

            -- Buffer is a directory
            local directory = vim.fn.isdirectory(data.file) == 1

            -- Buffer is a [No Name]
            local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

            if real_file then
                -- Open nvim-tree, find the file but don't focus it
                -- require("nvim-tree.api").tree.toggle({
                --     focus = false,
                --     find_file = true
                -- })
            elseif directory then
                -- cd to directory, then open nvim-tree
                vim.cmd.cd(data.file)
                require("nvim-tree.api").tree.open()
            elseif no_name then
                -- Open nvim-tree
                -- require("nvim-tree.api").tree.open()
            end
        end

        vim.api.nvim_create_autocmd({"VimEnter"}, {
            callback = open_nvim_tree
        })
    end
}
