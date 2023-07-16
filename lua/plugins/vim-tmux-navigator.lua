return {
  'christoomey/vim-tmux-navigator',
  keys = {
    {
      '<C-h>',
      '<cmd> TmuxNavigateLeft<CR>',
      desc = 'window left tmux',
    },
    {
      '<C-l>',
      '<cmd> TmuxNavigateRight<CR>',
      desc = 'window right tmux',
    },
    {
      '<C-j>',
      '<cmd> TmuxNavigateDown<CR>',
      desc = 'window down tmux',
    },
    {
      '<C-k>',
      '<cmd> TmuxNavigateUp<CR>',
      desc = 'window up tmux',
    },
  },
}
