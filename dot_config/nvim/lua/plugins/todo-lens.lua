return {
	{
		"gendonholaholo/todo-lens.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("todo_lens").setup({
				keywords = {
					TODO = { color = "#ff9e64", priority = 10 },
					FIXME = { color = "#e86671", priority = 10 },
					HACK = { color = "#bb9af7", priority = 5 },
					NOTE = { color = "#7dcfff", priority = 1 },
					BUG = { color = "#f7768e", priority = 15 },
					PERF = { color = "#9ece6a", priority = 8 },
				},
			})

			-- Enhanced TODO keymaps - comprehensive workflow support
			-- Core TODO operations (existing)
			vim.keymap.set("n", "<leader>tl", "<cmd>TodoList<CR>", { desc = "List TODOs" })
			vim.keymap.set("n", "<leader>tt", "<cmd>TodoToggle<CR>", { desc = "Toggle TODO highlighting" })
			vim.keymap.set("n", "<leader>tf", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
			
			-- Additional non-conflicting TODO keymaps for enhanced productivity
			vim.keymap.set("n", "<leader>tn", "<cmd>TodoNext<CR>", { desc = "Next TODO", silent = true })
			vim.keymap.set("n", "<leader>tp", "<cmd>TodoPrev<CR>", { desc = "Previous TODO", silent = true })
			vim.keymap.set("n", "<leader>tc", "<cmd>TodoQuickFix<CR>", { desc = "TODO QuickFix list", silent = true })
			vim.keymap.set("n", "<leader>ts", "<cmd>TodoLocList<CR>", { desc = "TODO Location list", silent = true })
		end,
	},
}
