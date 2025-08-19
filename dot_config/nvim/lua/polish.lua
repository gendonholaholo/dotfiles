-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Temporary deprecation warning suppression for plugin compatibility
-- TODO: Remove once all plugins are updated for Neovim 0.11+
local old_notify = vim.notify
vim.notify = function(msg, level, opts)
  -- Suppress specific deprecation warnings from known plugin compatibility issues
  if type(msg) == "string" then
    if msg:match("vim%.str_utfindex is deprecated") or
       msg:match("vim%.tbl_islist is deprecated") or 
       msg:match("vim%.validate is deprecated") then
      return -- Suppress these specific warnings
    end
  end
  return old_notify(msg, level, opts)
end

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
