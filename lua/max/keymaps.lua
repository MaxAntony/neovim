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
