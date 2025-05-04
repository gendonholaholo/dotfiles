-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Hide the window title bar and borders
config.window_decorations = "NONE"

-- Disable the tab bar
config.enable_tab_bar = false

-- Set a dark color scheme (e.g., Catppuccin Mocha)
-- config.color_scheme = 'Catppuccin Mocha'

-- Override background color to be pure black
config.colors = { background = "#000000" }
-- config.window_background_opacity = 1
-- config.win32_system_backdrop = "Acrylic"

-- Add some padding around the terminal content
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- Font configuration (optional, uncomment and customize if needed)
-- config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 12.5

-- Return the configuration to wezterm
return config
