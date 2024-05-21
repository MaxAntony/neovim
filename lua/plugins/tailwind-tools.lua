return {
  'luckasRanarison/tailwind-tools.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    document_color = {
      enabled = false,
    },
    conceal = {
      enabled = true,
      -- https://github.com/luckasRanarison/tailwind-tools.nvim/issues/3
      symbol = '󱏿', -- only a single character is allowed
    },
  },
}
