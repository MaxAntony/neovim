local M = {}
function M.setup()
  require('onedark').setup {
    style = 'darker',
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
    code_style = {
      keywords = 'italic'
    }
  }
  require('onedark').load()
end

return M
