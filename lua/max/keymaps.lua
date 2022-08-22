local function map(mode --[[string]] , lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- NORMAL
map("n", "<Leader>w", ":w<cr>")
map('n', '<Leader>q', ':q<cr>')
map("n", "<Leader>Q", ":wqa<cr>") -- quit nvim writing all
map("n", "<Leader>e", ":NvimTreeToggle<cr>")
-- floatTerm
map('n', '<Leader>te', ':FloatermToggle<cr>')
-- telescope
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

-- TERMINAL
map('t', '<ESC>', '<C-\\><C-n>')
