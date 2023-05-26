local cmd = vim.cmd
local o = vim.o
local g = vim.g
local opt = vim.opt

-- Global settings
cmd('set cursorline')
cmd('set noshowmode')
--cmd "set noshowcmd"
cmd('set sw=2')
cmd('set completeopt=menu,menuone,noselect')
cmd('set tabstop=2')
cmd('set shiftwidth=2')
cmd('set expandtab')
cmd('set smartindent')

g.mapleader = ' '
o.background = 'dark'

opt.timeoutlen = 300
opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
--opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = 'yes' -- Always show sign column
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.scrolloff = 8
-- nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- bottom status
o.ls = 0
o.ch = 0

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- UFO folding
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
