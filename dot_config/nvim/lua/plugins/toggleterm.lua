return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			-- Enhanced animations and visual effects
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-space>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2, -- Degree of shading (1-3, 2 is good balance)
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,

			-- Enhanced float terminal configuration
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ...
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
				winblend = 10, -- Transparency (0-100)
				highlights = {
					border = "Normal",
					background = "Normal",
				},
				title_pos = "center", -- 'left' | 'center' | 'right'
			},

			-- Window management
			winbar = {
				enabled = false,
				name_formatter = function(term)
					return term.name
				end,
			},
		},
	},
}
