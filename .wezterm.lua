local wezterm = require("wezterm")
local config = {
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	-- default_prog = { "wsl", "su", "yvanflorian" },
	color_scheme = "Chameleon (Gogh)",
	font = wezterm.font("Iosevka Nerd Font", { weight = "Regular" }),
	font_size = 16.45,
	window_background_image = wezterm.config_dir .. "/horizon.jpg",
	window_background_image_hsb = {
		brightness = 0.15,
		hue = 0.9,
		saturation = 0.8,
	},
	-- initial_rows = 1000,
	-- initial_cols = 1000,
}

return config
