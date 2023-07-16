-- https://github.com/HiPhish/nvim-ts-rainbow2/issues/18#issuecomment-1522320638
-- for react replace content rainbow_delimiters.scm with

-- (jsx_element
--   (jsx_opening_element
--     name: (_) @opening)
--   (jsx_closing_element
--     name: (_) @closing)) @container
--
-- (jsx_self_closing_element
--   name: (_) @intermediate) @container
--
-- (jsx_expression
--   "{" @opening
--   "}" @closing) @container

return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    -- This module contains a number of default definitions
    local rainbow_delimiters = require('rainbow-delimiters')

    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }
  end,
}
