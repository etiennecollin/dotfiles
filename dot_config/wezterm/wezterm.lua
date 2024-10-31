local config = {}

local wezterm = require("wezterm")
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configure looks
config.color_scheme = "Gruvbox dark, medium (base16)"

config.font = wezterm.font("Maple Mono NF", { weight = "Regular" })
config.font_size = 16
config.harfbuzz_features = { "zero", "cv01", "cv02", "ss03" }

config.adjust_window_size_when_changing_font_size = false
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 400
config.enable_scroll_bar = true
config.max_fps = 120

-- Config for windows
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.7 }

config.window_background_opacity = 1
config.window_decorations = "RESIZE"
config.window_frame = { font_size = 16 }
config.window_padding = { left = 10, right = 10, top = 10, bottom = 0 }

-- Other settings
config.use_dead_keys = true
config.enable_kitty_graphics = true
config.front_end = "WebGpu"
config.webgpu_power_preference = "LowPower"
-- config.term = "xterm-kitty"

return config
