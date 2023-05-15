local M = {}

--- configure gruvbox theme plugin
--- @param loadTheme boolean # activate gruvbox theme
function M.setup(loadTheme)
  if loadTheme then
    vim.cmd([[colorscheme tokyonight]])
    require('tokyonight').setup()
  end
end

return M
