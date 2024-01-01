local config = {}

local wezterm = require("wezterm")
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configure looks
config.color_scheme = "tokyonight_night"
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 16

-- config.window_background_opacity = 0.85
-- config.text_background_opacity = 0.3
-- config.window_background_image = "/Users/etiennecollin/github/anime/skyline.jpg"
config.window_background_image_hsb = {
	brightness = 0.1,
}

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Config for window
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	font_size = 16,
}
config.window_decorations = "RESIZE"
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.2cell",
	bottom = "0.2cell",
}

-- Other settings
config.use_dead_keys = true
config.enable_scroll_bar = true
config.adjust_window_size_when_changing_font_size = false

return config
