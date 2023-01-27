local M = {}
function M.setup()
  require('colorizer').setup({
    {
      'scss',
      typescript = { no_names = true },
      'css',
      'javascript',
      '!floaterm',
      '!NvimTree',
      '!Telescope',
      '!mason',
    },
  })
end

return M
