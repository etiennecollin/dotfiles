local M = {}

-- Be sure to explicitly define these LuaSnip node abbreviations!
local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node

-- Get content of visual selection
function M.get_visual(args, parent)
    if (#parent.snippet.env.SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

function M.in_text()
    return not in_mathzone() and not in_comment()
end

function M.begins_line()
    local cur_line = vim.api.nvim_get_current_line()
    -- Checks if the current line consists of whitespace and then the snippet
    -- TODO: Fix limitation that the snippet cannot contain whitespace itself
    return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

return M
