-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

	-- == Examples of Adding Plugins ==

	-- {
	--   "jackMort/ChatGPT.nvim",
	--   event = "VeryLazy",
	--   config = function() require("chatgpt").setup() end,
	--   dependencies = {
	--     "MunifTanjim/nui.nvim",
	--     "nvim-lua/plenary.nvim",
	--     "nvim-telescope/telescope.nvim",
	--   },
	-- },

	{ "rmagatti/logger.nvim" },

	{
		"andweeb/presence.nvim",
		lazy = false,
		opts = {
			auto_update = false, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
		},
	},

	-- {
	--   "wakatime/vim-wakatime",
	--   lazy = false,
	-- },

	{
		"vyfor/cord.nvim",
		build = "./build || .\\build",
		"IogaMaster/neocord",
		event = "VeryLazy",
		opts = {},
	},

	{
		"ngtuonghy/live-server-nvim",
		event = "VeryLazy",
		build = ":LiveServerInstall",
		opts = {
			custom = {
				"--port=8080",
				"--no-css-inject",
			},
			serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
			open = "folder", -- folder|cwd     --default
		},
	},

	{
		"echasnovski/mini.nvim",
		version = "*",
	},

	{
		"nvzone/volt",
		{ "nvzone/timerly", cmd = "TimerlyToggle" },
	},

	{
		"tamton-aquib/mpv.nvim",
		config = true,
	},

	"andweeb/presence.nvim",
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			theme = {
				variant = "dark",
				saturation = 1,
				highlights = {
					Comment = { fg = "#00aaaa", bg = "NONE", italic = false },
					Constant = { fg = "#00ffff", bg = "NONE" },
					Identifier = { fg = "#ff00ff", bg = "NONE" },
					Function = { fg = "#00ff00", bg = "NONE" },
					Statement = { fg = "#ffffff", bg = "NONE", bold = true },
					PreProc = { fg = "#ffff00", bg = "NONE" },
					Type = { fg = "#00ff00", bg = "NONE", bold = true },
					Special = { fg = "#ff0000", bg = "NONE" },
					Delimiter = { fg = "#ffff00", bg = "NONE" },
				},
			},
		},
	},

	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard") -- Impor tema dashboard default

			-- Buat tabel opts baru
			local opts = {}

			-- Ambil layout dari konfigurasi default dashboard
			opts.layout = dashboard.config.layout

			-- Buat section dan header
			opts.section = dashboard.section or {}
			opts.section.header = dashboard.section.header or {}

			-- Tetapkan header kustom Anda
			opts.section.header.val = {
				"██████╗  ██████╗ ███████╗",
				"██╔════╝ ██╔═══██╗██╔════╝",
				"██║  ███╗██║   ██║███████╗",
				"██║   ██║██║   ██║╚════██║",
				"╚██████╔╝╚██████╔╝███████║",
				"╚═════╝  ╚═════╝ ╚══════╝",
				"        ███████╗██╗",
				"        ██╔════╝██║",
				"  █████╗█████╗  ██║",
				"  ╚════╝██╔══╝  ██║",
				"        ███████╗███████╗",
				"        ╚══════╝╚══════╝",
			}

			-- Panggil setup alpha dengan opts yang sudah dikonstruksi
			alpha.setup(opts)
		end,
	},

	-- You can disable default plugins as follows:
	{ "max397574/better-escape.nvim", enabled = false },

	-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
	{
		"L3MON4D3/LuaSnip",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom luasnip configuration such as filetype extend or custom snippets
			local luasnip = require("luasnip")
			luasnip.filetype_extend("javascript", { "javascriptreact" })
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function(plugin, opts)
			require("astronvim.plugins.configs.nvim-autopairs")(plugin, opts) -- include the default astronvim config that calls the setup call
			-- add more custom autopairs configuration such as custom rules
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			npairs.add_rules(
				{
					Rule("$", "$", { "tex", "latex" })
						-- don't add a pair if the next character is %
						:with_pair(cond.not_after_regex("%%"))
						-- don't add a pair if  the previous character is xxx
						:with_pair(
							cond.not_before_regex("xxx", 3)
						)
						-- don't move right when repeat character
						:with_move(cond.none())
						-- don't delete if the next character is xx
						:with_del(cond.not_after_regex("xx"))
						-- disable adding a newline when you press <cr>
						:with_cr(cond.none()),
				},
				-- disable for .vim files, but it work for another filetypes
				Rule("a", "a", "-vim")
			)
		end,
	},
}
