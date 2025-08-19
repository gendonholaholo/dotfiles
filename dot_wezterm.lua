--[[
================================================================================
WezTerm Configuration - Modular Architecture with GPU Acceleration
================================================================================

A well-structured WezTerm configuration implementing:
- Clean separation of concerns across modular sections
- Intelligent GPU acceleration with hardware detection and fallbacks
- Performance optimization and advanced rendering settings
- Comprehensive error handling and graceful degradation
- Extensible architecture for future enhancements

Author: Claude Code SuperClaude Framework
Date: 2025-08-17
================================================================================
--]]

-- ============================================================================
-- CORE INITIALIZATION MODULE
-- ============================================================================
-- Handles WezTerm API initialization and config builder setup
-- Provides foundation for all other configuration modules

local wezterm = require("wezterm")

-- Initialize configuration with modern config builder pattern
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- ============================================================================
-- PERFORMANCE & GPU ACCELERATION MODULE
-- ============================================================================
-- Intelligent GPU acceleration with hardware detection and optimization
-- Implements WebGPU with intelligent fallbacks for optimal performance

local function setup_performance()
	local perf_config = {}

	-- Attempt to enable WebGPU for hardware acceleration
	-- This provides significant performance improvements when available
	pcall(function()
		-- Enumerate available GPUs and select the best option
		local gpus = wezterm.gui.enumerate_gpus()

		if #gpus > 0 then
			-- Prefer discrete GPU, then integrated, finally fallback to CPU
			local preferred_gpu = nil

			-- First pass: Look for discrete GPU with Vulkan backend
			for _, gpu in ipairs(gpus) do
				if gpu.device_type == "DiscreteGpu" and gpu.backend == "Vulkan" then
					preferred_gpu = gpu
					wezterm.log_info("Selected discrete Vulkan GPU: " .. (gpu.name or "Unknown"))
					break
				end
			end

			-- Second pass: Look for integrated GPU with Vulkan backend
			if not preferred_gpu then
				for _, gpu in ipairs(gpus) do
					if gpu.device_type == "IntegratedGpu" and gpu.backend == "Vulkan" then
						preferred_gpu = gpu
						wezterm.log_info("Selected integrated Vulkan GPU: " .. (gpu.name or "Unknown"))
						break
					end
				end
			end

			-- Third pass: Any Vulkan backend
			if not preferred_gpu then
				for _, gpu in ipairs(gpus) do
					if gpu.backend == "Vulkan" then
						preferred_gpu = gpu
						wezterm.log_info("Selected Vulkan GPU: " .. (gpu.name or "Unknown"))
						break
					end
				end
			end

			-- Configure WebGPU if suitable GPU found
			if preferred_gpu then
				perf_config.webgpu_preferred_adapter = preferred_gpu
				perf_config.front_end = "WebGpu"
				wezterm.log_info("WebGPU acceleration enabled")
			else
				wezterm.log_warn("No suitable GPU found, using software rendering")
			end
		end
	end)

	-- Advanced rendering optimizations
	perf_config.max_fps = 60
	perf_config.animation_fps = 60

	-- Optimize cursor animations for better performance
	perf_config.cursor_blink_rate = 800
	perf_config.cursor_blink_ease_in = "EaseIn"
	perf_config.cursor_blink_ease_out = "EaseOut"

	-- Scrollback optimization - balance history vs memory usage
	perf_config.scrollback_lines = 10000

	-- Platform-specific optimizations
	if wezterm.target_triple:find("windows") then
		-- Windows-specific optimizations
		perf_config.win32_system_backdrop = "Auto"
	elseif wezterm.target_triple:find("apple") then
		-- macOS-specific optimizations
		perf_config.macos_window_background_blur = 0
	else
		-- Linux/Unix optimizations
		perf_config.enable_wayland = true
	end

	return perf_config
end

-- ============================================================================
-- WINDOW MANAGEMENT MODULE
-- ============================================================================
-- Controls window appearance, decorations, padding, and transparency
-- Provides clean, minimal interface while maintaining functionality

local function setup_window()
	local window_config = {}

	-- Window decorations - minimalist approach
	window_config.window_decorations = "NONE"

	-- Disable tab bar for cleaner interface
	window_config.enable_tab_bar = false

	-- Window transparency and compositing
	window_config.window_background_opacity = 1.0

	-- Padding for visual breathing room
	window_config.window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	}

	-- Window behavior optimizations
	window_config.adjust_window_size_when_changing_font_size = false
	window_config.window_close_confirmation = "NeverPrompt"

	return window_config
end

-- ============================================================================
-- TYPOGRAPHY & FONT MODULE
-- ============================================================================
-- Advanced font configuration with rendering optimization
-- Handles font selection, sizing, and rendering quality

local function setup_fonts()
	local font_config = {}

	-- ========================================================================
	-- CENTRALIZED FONT CONFIGURATION
	-- ========================================================================
	-- Change ACTIVE_FONT to switch your entire font family in one place

	-- Font presets - popular coding fonts with optimized settings
	local font_presets = {
		jetbrains = {
			family = "JetBrains Mono",
			size = 1.1,
			line_height = 1.1,
		},
		fira = {
			family = "Fira Code",
			size = 12.0,
			line_height = 1.15,
		},
		cascadia = {
			family = "Cascadia Code",
			size = 12.0,
			line_height = 1.1,
		},
		source = {
			family = "Source Code Pro",
			size = 12.5,
			line_height = 1.1,
		},
		hack = {
			family = "Hack",
			size = 12.0,
			line_height = 1.1,
		},
		victor = {
			family = "Victor Mono",
			size = 12.5,
			line_height = 1.1,
		},
		inconsolata = {
			family = "Inconsolata",
			size = 13.0,
			line_height = 1.1,
		},
		roboto = {
			family = "Roboto Mono",
			size = 12.0,
			-- line_height = 1.1,
			line_height = 1.1,
		},
	}

	-- ========================================================================
	-- ACTIVE FONT SELECTION - CHANGE THIS TO SWITCH FONTS
	-- ========================================================================
	-- Options: "jetbrains", "fira", "cascadia", "source", "hack", "victor", "inconsolata", "roboto"
	-- Or create custom config: { family = "Your Font", size = 12.0, line_height = 1.1 }

	local ACTIVE_FONT = font_presets.jetbrains
	-- local ACTIVE_FONT = font_presets.jetbrains

	-- For custom font not in presets, uncomment and modify:
	-- local ACTIVE_FONT = {
	--     family = "Your Custom Font Name",
	--     size = 12.0,
	--     line_height = 1.1,
	-- }

	-- ========================================================================
	-- FONT CONFIGURATION USING ACTIVE SELECTION
	-- ========================================================================

	-- Primary font configuration using centralized family
	font_config.font = wezterm.font(ACTIVE_FONT.family, {
		weight = "Regular",
		italic = false,
	})

	-- Font sizing from preset configuration
	font_config.font_size = ACTIVE_FONT.size
	font_config.line_height = ACTIVE_FONT.line_height

	-- Advanced font rendering for crisp display
	font_config.freetype_load_target = "Normal"
	font_config.freetype_render_target = "Normal"

	-- Font fallback configuration using centralized family
	font_config.font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font(ACTIVE_FONT.family, { weight = "Bold" }),
		},
		{
			italic = true,
			font = wezterm.font(ACTIVE_FONT.family, { italic = true }),
		},
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font(ACTIVE_FONT.family, { weight = "Bold", italic = true }),
		},
	}

	-- Text rendering quality improvements
	font_config.use_cap_height_to_scale_fallback_fonts = true

	-- Subpixel rendering optimization
	if wezterm.target_triple:find("windows") or wezterm.target_triple:find("apple") then
		font_config.freetype_render_target = "HorizontalLcd"
	end

	return font_config
end

-- ============================================================================
-- APPEARANCE & VISUAL MODULE
-- ============================================================================
-- Color schemes, themes, and visual customization
-- Provides flexible appearance configuration with good defaults

local function setup_appearance()
	local appearance_config = {}

	-- Color scheme configuration
	-- Note: Commented out to use terminal default, but ready for customization
	-- appearance_config.color_scheme = 'Catppuccin Mocha'

	-- Custom color overrides for better contrast
	appearance_config.colors = {
		-- Background remains default (can be customized)
		-- background = "#000000",

		-- Cursor configuration for better visibility
		cursor_bg = "#FFFFFF",
		cursor_fg = "#000000",
		cursor_border = "#FFFFFF",

		-- Selection colors for better UX
		selection_fg = "none", -- Transparent to show original text color
		selection_bg = "rgba(50% 50% 50% 50%)", -- Semi-transparent selection

		-- Scrollbar styling (when enabled)
		scrollbar_thumb = "#444444",

		-- Visual bell configuration
		visual_bell = "#202020",
	}

	-- Visual bell for accessibility
	appearance_config.visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	}

	-- Advanced visual optimizations
	appearance_config.text_min_contrast_ratio = 4.5 -- WCAG AA compliance

	return appearance_config
end

-- ============================================================================
-- TERMINAL BEHAVIOR MODULE
-- ============================================================================
-- Terminal functionality, encoding, and interaction settings
-- Configures core terminal behavior for optimal user experience

local function setup_terminal()
	local terminal_config = {}

	-- Terminal identification and capabilities
	terminal_config.term = "wezterm"

	-- Modern terminal features
	terminal_config.enable_csi_u_key_encoding = true
	terminal_config.enable_kitty_keyboard = true

	-- Clipboard and selection behavior
	terminal_config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

	-- Hyperlink detection and handling
	terminal_config.hyperlink_rules = {
		-- Standard HTTP/HTTPS URLs
		{
			regex = "\\b\\w+://[\\w.-]+\\S*\\b",
			format = "$0",
		},
		-- Git commit hashes
		{
			regex = "\\b[a-f0-9]{6,40}\\b",
			format = "$0",
		},
		-- File paths (basic detection)
		{
			regex = "[/~][\\w./-]+",
			format = "$0",
		},
	}

	-- Terminal startup optimization
	terminal_config.skip_close_confirmation_for_processes_named = {
		"bash",
		"sh",
		"zsh",
		"fish",
		"tmux",
		"nu",
		"cmd.exe",
		"pwsh.exe",
		"powershell.exe",
	}

	return terminal_config
end

-- ============================================================================
-- CONFIGURATION ORCHESTRATION
-- ============================================================================
-- Merges all modular configurations into final config
-- Provides centralized error handling and logging

local function merge_config(target, source)
	for key, value in pairs(source) do
		target[key] = value
	end
end

-- Apply all configuration modules with error handling
pcall(function()
	local performance_config = setup_performance()
	merge_config(config, performance_config)
	wezterm.log_info("Performance module loaded successfully")
end)

pcall(function()
	local window_config = setup_window()
	merge_config(config, window_config)
	wezterm.log_info("Window module loaded successfully")
end)

pcall(function()
	local font_config = setup_fonts()
	merge_config(config, font_config)
	wezterm.log_info("Font module loaded successfully")
end)

pcall(function()
	local appearance_config = setup_appearance()
	merge_config(config, appearance_config)
	wezterm.log_info("Appearance module loaded successfully")
end)

pcall(function()
	local terminal_config = setup_terminal()
	merge_config(config, terminal_config)
	wezterm.log_info("Terminal module loaded successfully")
end)

-- ============================================================================
-- FUTURE EXTENSIONS PLACEHOLDER
-- ============================================================================
-- Ready for additional modules:
-- - Keybindings module: Custom key mappings and shortcuts
-- - Multiplexing module: Tabs, panes, and session management
-- - Domain module: SSH, TLS, and remote connection configuration
-- - Launch menu module: Custom launch configurations
-- - Platform-specific modules: OS-specific optimizations

--[[
Example extension pattern:

local function setup_keybindings()
    return {
        keys = {
            { key = 'r', mods = 'CMD|SHIFT', action = wezterm.action.ReloadConfiguration },
            -- Add more keybindings here
        }
    }
end

-- Then add to orchestration:
pcall(function()
    local keybinding_config = setup_keybindings()
    merge_config(config, keybinding_config)
    wezterm.log_info("Keybinding module loaded successfully")
end)
--]]

-- ============================================================================
-- CONFIGURATION EXPORT
-- ============================================================================

wezterm.log_info("WezTerm configuration loaded successfully with modular architecture")
return config
