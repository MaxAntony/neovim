local M = {}
-- load onedark theme
-- @param load boolean load
function M.setup(params)
  require('onedark').setup({
    style = 'darker',
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- key bind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' }, -- List of styles to toggle between
    code_style = {
      keywords = 'italic',
      comments = 'italic',
      functions = 'italic',
    },
  })
  require('onedark').load()
end

return M
