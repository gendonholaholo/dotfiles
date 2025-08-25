-- File: lua/plugins/rest.lua
-- Konfigurasi lengkap untuk rest.nvim dan semua dependensinya

return {
	-- 1. Fidget UI untuk notifikasi (dependensi)
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-- 2. Mason sebagai dasar untuk instalasi tool
	{
		"williamboman/mason.nvim",
		lazy = false,
		priority = 1000,
	},

	-- 3. Installer untuk Mason (dependensi)
	-- {
	-- 	"WhoIsSethDaniel/mason-tool-installer.nvim",
	-- 	dependencies = { "williamboman/mason.nvim" },
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			{
	-- 				"luarocks",
	-- 				packages = { "xml2lua", "lua-mimetypes" },
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- 4. Plugin rest.nvim (TARGET UTAMA)
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("rest-nvim").setup({
				rocks = {
					hererocks = true,
				},
				result = {
					split_horizontal = false,
					split_in_place = false,
					behavior = {
						decode_url = true,
						show_info = {
							url = true,
							headers = true,
							http_info = true,
							curl_command = true,
						},
					},
				},
				highlight = {
					enabled = true,
					timeout = 750,
				},
				jump_to_request = false,
				env_file = '.env',
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},
}
