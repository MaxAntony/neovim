local wk = require('which-key')

wk.register({
  ['<S-h>'] = { ':bprevious<cr>', 'switch previous buffer' },
  ['<S-l>'] = { ':bnext<cr>', 'switch next buffer' },
  n = { 'nzz', 'next match on center' },
  N = { 'Nzz', 'previous match on center' },
  ['<ESC>'] = { ':nohlsearch<Bar>:echo<CR>', 'clear search highlight' },
  ['<leader>'] = {
    w = { '<cmd>w<cr>', 'write file' },
    q = { '<cmd>q<cr>', 'quit' },
    Q = { '<cmd>wqa<cr>', 'quit writing all files' },
    e = { ':NvimTreeToggle<cr>', 'toggle explorer' },
    f = {
      name = 'Telescope',
      f = { ':NvimTreeClose<cr>:Telescope find_files<cr>', 'find files' },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      g = { ':NvimTreeClose<cr>:Telescope live_grep<cr>', 'live grep' },
      b = {
        ":NvimTreeClose<cr>:lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
        'buffers',
      },
      h = { ':NvimTreeClose<cr>:Telescope help_tags<cr>', 'help tags' },
    },
    t = {
      name = 'Toggleterm',
      e = { ':ToggleTerm<cr>', 'toggle' },
    },
  },
}, { mode = 'n' })

-- TERMINAL
wk.register({
  ['<ESC>'] = { '<C-\\><C-n>', 'quit from terminal' },
}, { mode = 't' })

-- Ufo plugin
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
wk.register({
  z = {
    R = { ':lua require("ufo").openAllFolds()<cr>', 'open all folds' },
    M = { ':lua require("ufo").closeAllFolds()<cr>', 'close all folds' },
  },
}, { mode = 'n' })
