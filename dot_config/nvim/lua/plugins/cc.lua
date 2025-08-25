local toggle_key = "<C-\\>"
return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = function(_, opts)
			require("claudecode").setup(opts)

			-- Add transparency every time claude terminal becomes visible
			vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter", "WinEnter", "BufEnter" }, {
				pattern = "*",
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					local bufname = vim.api.nvim_buf_get_name(buf)
					local win = vim.api.nvim_get_current_win()

					-- Check if this is claude terminal
					if
						vim.bo[buf].buftype == "terminal"
						and (string.match(bufname, "claude") or string.match(bufname, "Claude"))
					then
						-- Use defer_fn to ensure it applies after window is fully setup
						vim.defer_fn(function()
							-- Force transparency with stronger settings
							vim.wo[win].winblend = 10
							vim.api.nvim_win_set_option(win, "winblend", 10) -- Alternative API
							-- Force window refresh to apply changes
							vim.cmd("redraw")
						end, 10) -- Small delay to ensure window is ready
					end
				end,
			})

			-- Force focus back to claude terminal after diff opens
			vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
				pattern = "*",
				callback = function()
					local current_win = vim.api.nvim_get_current_win()

					-- Check if current window is in diff mode (diff is window-local option)
					if vim.wo[current_win].diff then
						vim.defer_fn(function()
							-- Find claude terminal window and focus it
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								local buf = vim.api.nvim_win_get_buf(win)
								local bufname = vim.api.nvim_buf_get_name(buf)
								if vim.bo[buf].buftype == "terminal" and string.match(bufname, "claude") then
									-- Bypass smart-splits conflicts
									vim.api.nvim_set_current_win(win)
									vim.api.nvim_feedkeys("i", "n", false) -- Enter insert mode
									break
								end
							end
						end, 250) -- 250ms delay
					end
				end,
			})
		end,
		opts = {
			terminal = {
				provider = "snacks",
				snacks_win_opts = {
					position = "float",
					width = 0.9,
					height = 0.9,
					animate = true, -- Keep animations (works)
					border = "rounded", -- Keep rounded borders (works)
					-- Remove failed backdrop experiments
					keys = {
						claude_hide = {
							toggle_key,
							function(self)
								self:hide()
							end,
							mode = "t",
							desc = "Hide",
						},
					},
				},
			},
			diff_opts = {
				keep_terminal_focus = true, -- If true, moves focus back to terminal after diff opens
				open_in_current_tab = true,
			},
		},
		keys = {
			{ toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
			},
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
