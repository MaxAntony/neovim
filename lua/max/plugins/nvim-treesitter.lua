local M = {}
function M.setup()
  local rainbow = require('ts-rainbow')
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
      'luadoc',
      'make',
      'markdown_inline',
      'mermaid',
      'query',
      'regex',
      'yaml',
      'vimdoc',
      'sql',
      'scss',
      'rust',
      'go',
      'bash',
      'comment',
      'dart',
      'diff',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'ini',
      'yaml',
    },
    -- auto_install = false,
    highlight = { enable = true },
    rainbow = {
      -- colors = { '#cc241d', '#a89984', '#b16286', '#d79921', '#689d6a', '#d65d0e', '#458588' },
      enable = true,
      query = { 'rainbow-parens', html = 'rainbow-tags' },
      strategy = { rainbow.strategy['global'], commonLisp = rainbow.strategy['local'] },
      -- disable = { 'html' },
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
