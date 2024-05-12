return {
  'hrsh7th/nvim-cmp',
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require('cmp')
    opts.window = {
      -- https://github.com/LazyVim/LazyVim/issues/556
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
  end,
}
