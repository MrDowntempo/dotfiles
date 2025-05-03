-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("0xProto")
config.force_reverse_video_cursor = true

-- greater compatibility
config.term = "wezterm"

-- New tabs instead of new windows
config.prefer_to_spawn_tabs = true

-- Alternate keybindings
config.keys = {
  -- Unbind the default Alt+Enter for toggling fullscreen
  { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },

  -- Now, assign F11 to toggle fullscreen
  { key = 'F11', mods = '', action = wezterm.action.ToggleFullScreen },
}

-- Function for choosing different fonts for different programs
wezterm.on("update-status", function(window, pane)
	local info = pane:get_foreground_process_info()
	if info == nil then
		return
	end
	if info.name == "blightmud" then
		window:set_config_overrides({font = wezterm.font("Anonymous Pro")})
	else
		window:set_config_overrides({font = wezterm.font("0xProto")})
	end
end)

-- config.use_cap_height_to_scale_fallback_fonts = true
config.font_rules = {
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font {
			family = 'ComicCodeLigatures',
			weight = 'Bold',
			style = 'Italic',
		},
	},
	{
		italic = true,
		intensity = 'Half',
		font = wezterm.font {
			family = 'ComicCodeLigatures',
			weight = 'DemiBold',
			style = 'Italic',
		},
	},
	{
		italic = true,
		intensity = 'Normal',
		font = wezterm.font {
			family = 'ComicCodeLigatures',
			style = 'Italic',
		},
	},
}

config.color_scheme = "Catppuccin Mocha" -- Best Theme

-- config.front_end = "WebGpu" -- Currently dealing with too many nvidia wayland bugs for WebGpu. ##OpenGL, WebGPU
-- config.webgpu_power_preference = "HighPerformance"

-- config.hide_tab_bar_if_only_one_tab = true
config.cursor_thickness = "1pt"

-- COLD NOT GET TO WORK. KDE ISSUE MAYBE?
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

config.window_frame = {
	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = '#181825',

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = '#181825',

	-- NOT NECCESSARY SINCE TAB BAR/WINDOW FRAME NOT COMBINED AS ABOVE
	-- Sets the font for the window frame (tab bar)
	font = require('wezterm').font({ family = 'OpenTTD Sans', weight = 'Bold' }),
  font_size = 11,
}



config.colors = {
	tab_bar = {

 -- The active tab is the one that has focus in the window
		active_tab = {
			bg_color = '#1e1e2e',
			fg_color = '#cdd6f4',
		},

		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = '#585b70',

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = '#11111b',
			fg_color = '#cdd6f4',
		},

		inactive_tab_hover = {
			bg_color = '#313244',
			fg_color = '#cdd6f4',
		},

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = '#181825',
			fg_color = '#cdd6f4',
		},

		new_tab_hover = {
			bg_color = '#181825',
			fg_color = '#a6e3a1',
		},

	},
}

-- -- Used to get Mac Style movement. Called Natural Text Editing in iTerm2. Might be nice, although vi commands are likely a better habbit to form.
-- -- https://www.reddit.com/r/wezterm/comments/15hfo32/wezterm_natural_text_editing/
-- config.keys = {
--   { mods = "OPT", key = "LeftArrow", action = action.SendKey({ mods = "ALT", key = "b" }) },
--   { mods = "OPT", key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },
--   { mods = "CMD", key = "LeftArrow", action = action.SendKey({ mods = "CTRL", key = "a" }) },
--   { mods = "CMD", key = "RightArrow", action = action.SendKey({ mods = "CTRL", key = "e" }) },
--   { mods = "CMD", key = "Backspace", action = action.SendKey({ mods = "CTRL", key = "u" }) },
-- }

-- Spawn a fish shell in login mode
-- currently turned off because pika uses pika-chsh
-- config.default_prog = { '/usr/bin/fish', '-l' }

-- and finally, return the configuration to wezterm
return config
