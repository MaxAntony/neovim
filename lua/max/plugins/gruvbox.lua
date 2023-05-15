local M = {}

--- configure gruvbox theme plugin
--- @param loadTheme boolean # activate gruvbox theme
function M.setup(loadTheme)
  if loadTheme then
    vim.cmd([[colorscheme gruvbox]])
  end
end

return M
