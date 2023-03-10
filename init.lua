local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable version
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('max.plugins')
require('max.defaults')
require('max.keymaps')
-- https://github.com/Nguyen-Hoang-Nam/nvim-dotfiles-kitty
