local function map(
	mode, --[[string]]
	lhs,
	rhs,
	opts
)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- NORMAL
map("n", "<Leader>w", ":w<cr>")
map("n", "<Leader>q", ":q<cr>")
map("n", "<Leader>Q", ":wqa<cr>") -- quit nvim writing all
map("n", "<Leader>e", ":NvimTreeToggle<cr>")
-- floatTerm
map("n", "<Leader>te", ":FloatermToggle<cr>")
-- telescope
map("n", "<leader>ff", ":NvimTreeClose<cr>:lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fg", ":NvimTreeClose<cr>:lua require('telescope.builtin').live_grep()<cr>")
map(
	"n",
	"<leader>fb",
	":NvimTreeClose<cr>:lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>"
)
map("n", "<leader>fh", ":NvimTreeClose<cr>:lua require('telescope.builtin').help_tags()<cr>")
-- switch buffer
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<S-l>", ":bnext<CR>")
-- center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")
-- cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")

-- TERMINAL
map("t", "<ESC>", "<C-\\><C-n>")

-- Ufo plugin
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
--vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
--vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
