local config = {}

local wezterm = require("wezterm")
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configure looks
config.color_scheme = "Sonokai (Gogh)"
config.font = wezterm.font("Maple Mono NF", { weight = "Regular" })
config.harfbuzz_features = { "zero", "cv01", "cv02", "ss03" }
config.font_size = 16

-- Configure window opacity
config.window_background_opacity = 1

-- Configure image background
-- config.text_background_opacity = 1
-- config.window_background_image = "/Users/etiennecollin/github/dotfiles/wallpapers/ancient_bristlecone_pine_forest.jpg"
-- config.window_background_image_hsb = {
-- 	brightness = 0.8,
-- }

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
config.window_padding = { left = 10, right = 10, top = 10, bottom = 0 }

-- Other settings
config.use_dead_keys = true
config.enable_scroll_bar = true
config.adjust_window_size_when_changing_font_size = false

return config
