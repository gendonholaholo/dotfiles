return {
  {
    'dnlhc/glance.nvim',
    cmd = 'Glance', -- Hanya muat plugin saat perintah :Glance digunakan
    config = function()
      -- Konfigurasi default (opsional, bisa di-uncomment dan diubah sesuai kebutuhan)
      -- require('glance').setup({
      --   height = 18, -- Tinggi jendela
      --   zindex = 45,
      --   preserve_win_context = true, -- Membutuhkan Neovim >= 0.10.0
      --   detached = function(winid)
      --     return vim.api.nvim_win_get_width(winid) < 100
      --   end,
      --   -- detached = true, -- Atau gunakan pengaturan tetap
      --   preview_win_opts = { -- Konfigurasi opsi jendela pratinjau
      --     cursorline = true,
      --     number = true,
      --     wrap = true,
      --   },
      --   border = {
      --     enable = false, -- Tampilkan border jendela. Hanya border horizontal yang diizinkan
      --     top_char = '―',
      --     bottom_char = '―',
      --   },
      --   list = {
      --     position = 'right', -- Posisi jendela daftar 'left'|'right'
      --     width = 0.33, -- Lebar sebagai persentase (0.1 hingga 0.5)
      --   },
      --   theme = {
      --     enable = true, -- Hasilkan warna berdasarkan colorscheme saat ini
      --     mode = 'auto', -- 'brighten'|'darken'|'auto'
      --   },
      --   mappings = {
      --     list = {
      --       ['j'] = require('glance').actions.next,
      --       ['k'] = require('glance').actions.previous,
      --       -- ... mapping lainnya
      --       ['q'] = require('glance').actions.close,
      --     },
      --     preview = {
      --       ['Q'] = require('glance').actions.close,
      --       -- ... mapping lainnya
      --     },
      --   },
      --   hooks = {},
      --   folds = {
      --     fold_closed = '',
      --     fold_open = '',
      --     folded = true,
      --   },
      --   indent_lines = {
      --     enable = true,
      --     icon = '│',
      --   },
      --   winbar = {
      --     enable = true, -- Membutuhkan Neovim >= 0.8
      --   },
      --   use_trouble_qf = false,
      -- })

      -- Keybindings (sesuai dokumentasi)
      vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>', { noremap = true, silent = true, desc = "Glance definitions" })
      vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>', { noremap = true, silent = true, desc = "Glance references" })
      vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>', { noremap = true, silent = true, desc = "Glance type definitions" })
      vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>', { noremap = true, silent = true, desc = "Glance implementations" })
    end,
  },
}
