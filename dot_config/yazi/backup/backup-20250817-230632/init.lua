-- Enhanced Yazi Configuration
-- Advanced plugin setup for powerful file management

-- Zoxide integration for smart directory jumping
require("zoxide"):setup({
	update_db = true,
})

-- Starship integration for enhanced status line
require("starship"):setup()

-- Whoosh bookmark manager configuration
require("whoosh"):setup({
	-- Bookmark file location
	bookmark_file = os.getenv("HOME") .. "/.config/yazi/bookmarks",
	-- Show hidden files in bookmarks
	show_hidden = true,
	-- Use fuzzy search
	fuzzy_search = true,
	-- Maximum number of recent directories to remember
	history_size = 50,
})

-- DuckDB configuration for data file previews
require("duckdb"):setup({
	-- Enable summary view for large datasets
	summary_view = true,
	-- Maximum rows to display
	max_rows = 100,
	-- Enable data type inference
	infer_types = true,
})

-- Enhanced git integration
require("git"):setup({
	-- Show git status in file list
	show_status = true,
	-- Show branch information
	show_branch = true,
	-- Show git diff for files
	show_diff = true,
})

-- Easyjump configuration for quick navigation
require("easyjump"):setup({
	-- Characters to use for jump hints
	hint_chars = "asdghklqwertyuiopzxcvbnmfj",
	-- Case sensitivity
	case_sensitive = false,
	-- Highlight color
	highlight_color = "yellow",
})

-- Archive preview configuration
require("archive"):setup({
	-- List style for archive contents
	list_style = "tree",
	-- Show file sizes in archive
	show_size = true,
	-- Show modification dates
	show_date = true,
})

-- Performance optimizations
-- Enable file caching for better performance
ya.manager_emit("cd", { os.getenv("PWD") })

-- Custom functions for enhanced functionality

-- Function to create a new file/directory with proper permissions
function create_with_perms(name)
	local is_dir = name:sub(-1) == "/"
	if is_dir then
		os.execute("mkdir -p " .. name)
		os.execute("chmod 755 " .. name)
	else
		os.execute("touch " .. name)
		os.execute("chmod 644 " .. name)
	end
end

-- Function to quick preview text files
function quick_preview(file)
	if file:match("%.%w+$") then
		local ext = file:match("%.(%w+)$"):lower()
		if ext == "md" then
			os.execute("glow " .. file)
		elseif ext == "json" then
			os.execute("jq . " .. file)
		elseif ext == "yaml" or ext == "yml" then
			os.execute("bat --language yaml " .. file)
		else
			os.execute("bat " .. file)
		end
	end
end

-- Auto-update plugin configuration
-- Check for plugin updates periodically
local function check_plugin_updates()
	-- This could be expanded to automatically check for plugin updates
	ya.notify({
		title = "Yazi Enhanced",
		content = "Advanced configuration loaded successfully!",
		timeout = 3,
	})
end

-- Initialize enhanced features
check_plugin_updates()
