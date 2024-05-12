return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'elgiano/nvim-treesitter-angular', branch = 'topic/jsx-fix' },
  opts = {
    rainbow = {
      enable = true,
      query = { 'rainbow-parens', html = 'rainbow-tags' },
      extended_mode = true,
      max_file_lines = nil,
    },
    -- nvim-ts-autotag
    autotag = {
      enable_close_on_slash = false,
    },
  },
}
