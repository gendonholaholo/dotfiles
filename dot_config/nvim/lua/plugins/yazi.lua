-- yazi.nvim - File manager integration
-- Repository: https://github.com/mikavilpas/yazi.nvim
-- Robust configuration that respects existing yazi configuration at ~/.config/yazi

-- DISABLED: yazi.nvim has issues with state persistence
-- Using oil.nvim instead for reliable F10 toggle behavior

if false then
---@type LazySpec  
return {
  "mikavilpas/yazi.nvim",
  version = "*", -- Use latest stable version
  event = "VeryLazy", -- Lazy load for better startup time
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    -- F10 to toggle yazi (main keybinding) - true toggle show/hide
    {
      "<F10>",
      mode = { "n", "v" },
      function()
        local yazi_module = require("yazi")
        
        -- CRITICAL FIX: Ensure cwd_file_path is initialized
        if not yazi_module.config.cwd_file_path then
          yazi_module.config.cwd_file_path = vim.fn.tempname() .. "_yazi_cwd"
          print("FIXED: Created cwd_file_path:", yazi_module.config.cwd_file_path)
        end
        
        -- Priority 1: Check if we're currently inside yazi terminal
        local current_buf = vim.api.nvim_get_current_buf()
        local buf_name = vim.api.nvim_buf_get_name(current_buf)  
        local buftype = vim.bo[current_buf].buftype
        local is_in_yazi = buftype == "terminal" and buf_name:match("yazi")
        
        if is_in_yazi then
          -- We're inside yazi - exit with 'q' to properly save state
          vim.api.nvim_feedkeys("q", "t", false)
        else
          -- We're outside yazi - always use toggle to preserve state  
          yazi_module.toggle()
        end
      end,
      desc = "Toggle Yazi with state persistence",
    },
    -- Alternative keybindings for different use cases
    {
      "<leader>yy",
      mode = { "n", "v" },
      "<cmd>Yazi<cr>",
      desc = "Open yazi at current file",
    },
    -- Test F9 as backup
    {
      "<F9>", 
      mode = { "n", "v" },
      function()
        print("F9 test pressed!")
        require("yazi").yazi()
      end,
      desc = "Test yazi open (F9)",
    },
    {
      "<leader>yw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi in working directory",
    },
    {
      "<leader>yt",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume last yazi session",
    },
  },
  ---@type YaziConfig
  opts = {
    -- Don't replace netrw - let user choose when to use yazi
    open_for_directories = false,
    
    -- Respect existing yazi configuration directory
    -- This ensures no conflicts with stable yazi config at ~/.config/yazi
    
    -- Enhanced floating window appearance
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_winblend = 0,
    yazi_floating_window_border = "rounded",
    
    -- Keep current directory behavior stable
    change_neovim_cwd_on_close = false,
    
    -- Enable multiple tabs for better workflow
    open_multiple_tabs = true,
    
    -- Enhanced buffer highlighting
    highlight_hovered_buffers_in_same_directory = true,
    highlight_groups = {
      hovered_buffer = nil, -- Use default highlighting
      hovered_buffer_in_same_directory = nil, -- Use default highlighting
    },
    
    -- System clipboard integration
    clipboard_register = "+",
    
    -- Comprehensive keymaps for file management
    keymaps = {
      show_help = "<f1>",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-x>",
      open_file_in_tab = "<c-t>",
      grep_in_directory = "<c-s>", -- Requires telescope/fzf-lua
      replace_in_directory = "<c-g>", -- Requires grug-far
      cycle_open_buffers = "<tab>",
      copy_relative_path_to_selected_files = "<c-y>",
      send_to_quickfix_list = "<c-q>",
      change_working_directory = "<c-\\>",
      open_and_pick_window = "<c-o>",
    },
    
    -- Custom keymapping function to add F10 inside yazi
    set_keymappings_function = function(yazi_buffer_id, config, context)
      -- Set F10 to exit yazi with proper state saving (same as 'q')
      vim.keymap.set("t", "<F10>", "q", { 
        buffer = yazi_buffer_id, 
        desc = "Exit yazi with state save (F10 toggle)" 
      })
      
      -- Keep ESC ESC for force quit (same as 'Q')  
      vim.keymap.set("t", "<Esc><Esc>", "Q", { 
        buffer = yazi_buffer_id, 
        desc = "Force quit yazi without state save" 
      })
    end,
    
    -- Logging for debugging (disabled by default)
    log_level = vim.log.levels.OFF,
    
    -- Enhanced integrations
    integrations = {
      -- Use bundled buffer deletion to preserve window layout
      bufdelete_implementation = "bundled-snacks",
      
      -- Telescope integration if available
      grep_in_directory = function(directory)
        if pcall(require, "telescope") then
          require("telescope.builtin").live_grep({
            cwd = directory,
            prompt_title = "Grep in " .. vim.fn.fnamemodify(directory, ":t"),
          })
        else
          vim.notify("Telescope not available for grep_in_directory", vim.log.levels.WARN)
        end
      end,
      
      grep_in_selected_files = function(selected_files)
        if pcall(require, "telescope") then
          require("telescope.builtin").live_grep({
            search_dirs = selected_files,
            prompt_title = "Grep in selected files",
          })
        else
          vim.notify("Telescope not available for grep_in_selected_files", vim.log.levels.WARN)
        end
      end,
      
      -- Grug-far integration if available
      replace_in_directory = function(directory)
        if pcall(require, "grug-far") then
          require("grug-far").grug_far({
            prefills = { paths = directory },
          })
        else
          vim.notify("grug-far not available for replace_in_directory", vim.log.levels.WARN)
        end
      end,
      
      replace_in_selected_files = function(selected_files)
        if pcall(require, "grug-far") then
          require("grug-far").grug_far({
            prefills = { paths = table.concat(selected_files, " ") },
          })
        else
          vim.notify("grug-far not available for replace_in_selected_files", vim.log.levels.WARN)
        end
      end,
    },
    

    
    -- Future features for better stability and state preservation
    future_features = {
      use_cwd_file = true, -- Save last directory to file
      new_shell_escaping = true,
    },
    
    -- Ensure state is preserved when yazi is closed
    change_neovim_cwd_on_close = false, -- Don't change nvim cwd
    
    -- Enhanced hooks for state management  
    hooks = {
      yazi_opened = function(preselected_path, yazi_buffer_id, config)
        -- Ensure proper buffer settings for yazi
        vim.api.nvim_buf_set_option(yazi_buffer_id, "filetype", "yazi")
      end,
      
      yazi_closed_successfully = function(chosen_file, config, state)
        -- State is automatically managed by yazi.nvim via cwd_file mechanism
        -- No manual intervention needed - plugin handles state persistence
        if chosen_file then
          vim.notify("File selected: " .. vim.fn.fnamemodify(chosen_file, ":t"), vim.log.levels.INFO)
        end
      end,
      
      yazi_opened_multiple_files = function(chosen_files, config, state)
        if #chosen_files > 1 then
          vim.notify(string.format("Selected %d files", #chosen_files), vim.log.levels.INFO)
        end
      end,
    },
  },
  
  -- Initialize without conflicting with netrw
  init = function()
    -- Only disable netrw if we're using yazi for directories
    -- Since open_for_directories = false, we keep netrw available
    
    -- CRITICAL: Force initialize yazi module to ensure cwd_file_path is set
    vim.schedule(function()
      local yazi = require("yazi")
      if not yazi.config.cwd_file_path then
        yazi.config.cwd_file_path = vim.fn.tempname() .. "_yazi_cwd"
        print("INIT: Force initialized cwd_file_path:", yazi.config.cwd_file_path)
      end
      if not yazi.config.chosen_file_path then
        yazi.config.chosen_file_path = vim.fn.tempname() .. "_yazi_chosen"
      end
    end)
    
    -- Manual keybinding as backup (removed since keys work)
    
    -- Create user commands for convenience
    vim.api.nvim_create_user_command("YaziToggle", function()
      require("yazi").yazi()
    end, {
      desc = "Toggle Yazi file manager",
    })
    
    vim.api.nvim_create_user_command("YaziCwd", function()
      require("yazi").yazi(nil, vim.fn.getcwd())
    end, {
      desc = "Open Yazi in current working directory",
    })
    
    -- Set up autocmds for better integration
    local yazi_group = vim.api.nvim_create_augroup("YaziConfig", { clear = true })
    
    -- Ensure yazi terminal has correct settings
    vim.api.nvim_create_autocmd("FileType", {
      group = yazi_group,
      pattern = "yazi",
      callback = function()
        -- Terminal-specific settings for yazi
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statuscolumn = ""
      end,
    })
  end,
}
end -- End of disabled yazi.nvim

-- Return empty table since yazi.nvim is disabled
return {}