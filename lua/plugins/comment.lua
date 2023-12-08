-- check this: https://github.com/mg979/vim-visual-multi
return {
  'numToStr/Comment.nvim',
  opts = {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  },
  lazy = false,
}
