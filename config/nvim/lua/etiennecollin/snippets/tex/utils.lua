local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local tex_utils = {}

-- Check if snippet to expand is in mathzone
tex_utils.in_mathzone = function() -- math context detection
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

-- Check if snippet to expand is in comment
tex_utils.in_comment = function() -- comment detection
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end

-- Check if snippet to expand is in text
tex_utils.in_text = function()
	return not tex_utils.in_mathzone() and not tex_utils.in_comment()
end

---------------------------------
-- Doesn't work for some reason???
tex_utils.in_env = function(name) -- generic environment detection
	local x, y = unpack(vim.fn["vimtex#env#is_inside"](name))
	return x ~= "0" and y ~= "0"
end
---------------------------------

-- Get content of visual selection
tex_utils.get_visual = function(args, parent)
	if #parent.snippet.env.SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
	else
		return sn(nil, i(1, ""))
	end
end

-- Check if snippet to expand is at the beginning of a line
tex_utils.begins_line = function()
	local cur_line = vim.api.nvim_get_current_line()
	-- Checks if the current line consists of whitespace and then the snippet
	-- TODO: Fix limitation that the snippet cannot contain whitespace itself
	return #cur_line == #string.match(cur_line, "%s*[^%s]+")
end

return tex_utils
