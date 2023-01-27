local M = {}
function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'tsx',
      'html',
      'lua',
      'typescript',
      'python',
      'graphql',
      'json',
      'jsdoc',
      'json5',
      'markdown',
      'prisma',
      'javascript',
    },
    auto_install = true,
    highlight = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  })
end

return M
