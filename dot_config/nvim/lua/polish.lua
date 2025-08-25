-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Deprecation warning suppression for plugin compatibility
-- Suppresses all vim.deprecated warnings to reduce noise during plugin updates
local old_notify = vim.notify
vim.notify = function(msg, level, opts)
	-- Suppress all deprecation warnings
	if type(msg) == "string" then
		if msg:match("deprecated") and msg:match("vim%.") then
			return -- Suppress all vim deprecation warnings
		end
	end
	return old_notify(msg, level, opts)
end


-- Set up custom filetypes
vim.filetype.add({
	extension = {
		foo = "fooscript",
	},
	filename = {
		["Foofile"] = "fooscript",
	},
	pattern = {
		["~/%.config/foo/.*"] = "fooscript",
	},
})
