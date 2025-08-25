return {
  "mrjones2014/smart-splits.nvim",
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile", "terminal" },
    -- Disable wrap-around navigation (anti-wrap)
    at_edge = "stop", -- or use "wrap" for wrapping behavior
  },
  config = function(_, opts)
    require("smart-splits").setup(opts)

    -- Set tmux aware detection
    vim.g.tmux_navigator_no_mappings = 1

    -- Key mappings for smart splits
    local keymap = vim.keymap.set

    -- Resize with Alt + hjkl (matching tmux config)
    keymap("n", "<M-h>", require("smart-splits").resize_left, { desc = "Resize left" })
    keymap("n", "<M-j>", require("smart-splits").resize_down, { desc = "Resize down" })
    keymap("n", "<M-k>", require("smart-splits").resize_up, { desc = "Resize up" })
    keymap("n", "<M-l>", require("smart-splits").resize_right, { desc = "Resize right" })

    -- Navigate with Ctrl + hjkl (matching tmux config)
    keymap("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left split" })
    keymap("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to down split" })
    keymap("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to up split" })
    keymap("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right split" })

    -- Swapping buffers
    keymap("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
    keymap("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
    keymap("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
    keymap("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })
  end,
}