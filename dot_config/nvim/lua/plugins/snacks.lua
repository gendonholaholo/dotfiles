return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- Visual decorative features for beautiful UX
			animate = { enabled = true, fps = 60, duration = 20 },
			dim = { enabled = true }, -- Focus active scope by dimming the rest
			scroll = { enabled = true }, -- Smooth scrolling
			statuscolumn = { enabled = true }, -- Pretty status column
			input = { enabled = true }, -- Better vim.ui.input
			notifier = { 
				enabled = true,
				timeout = 3000,
				width = { min = 40, max = 0.4 },
				height = { min = 1, max = 0.6 },
				margin = { top = 0, right = 1, bottom = 0 },
				padding = true,
				sort = { "level", "added" },
				level = vim.log.levels.TRACE,
				icons = {
					error = " ",
					warn = " ",
					info = " ",
					debug = " ",
					trace = " ",
				},
				style = "compact", -- compact|fancy|minimal
			},
			
			-- Image processing
			image = {
				enabled = true,
				formats = {
					"png", "jpg", "jpeg", "gif", "bmp", "webp", 
					"tiff", "heic", "avif", "mp4", "mov", "avi", 
					"mkv", "webm", "pdf",
				},
			},
			
			-- Enhanced window management
			win = {
				animate = {
					duration = 20, -- ms per step
					easing = "out_cubic", -- More elegant easing
					fps = 60,
				},
				show = true,
				fixbuf = true,
				relative = "editor",
				position = "float",
				minimal = true,
				width = 0.9,
				height = 0.9,
				backdrop = 60,
				zindex = 50,
				border = "rounded",
				wo = {
					winhighlight = "Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC",
				},
				bo = {},
				keys = {
					q = "close",
				},
			},
		},
	},
}