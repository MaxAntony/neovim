-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- vim.opt.breakindent = true
opt.wrap = true
opt.linebreak = true

-- recommended* for vgit
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'

-- remove transparency for cmp popup window
vim.o.pb = 0

-- https://detachhead.github.io/basedpyright/#/
vim.g.lazyvim_python_lsp = 'basedpyright'

-- activate inlay hints only on insert mode
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, true)
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     vim.lsp.inlay_hint(0, false)
--   end,
-- })
