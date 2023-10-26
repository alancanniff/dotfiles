local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("Cascadia Mono")
-- and finally, return the configuration to wezterm
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
-- config.window_frame = {
-- 	border_left_width = "0.2cell",
-- 	border_right_width = "0.2cell",
-- 	border_bottom_height = "0.1cell",
-- 	border_top_height = "0.1cell",
-- 	border_left_color = "grey",
-- 	border_right_color = "grey",
-- 	border_bottom_color = "grey",
-- 	border_top_color = "grey",
-- }

config.leader = { key = "b", mods = "CTRL" }
config.keys = {
	{ key = "s", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "v", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
}

return config
