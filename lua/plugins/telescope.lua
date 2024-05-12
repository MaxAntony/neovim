return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>fB',
      "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
      desc = 'last buffers',
    },
  },
}
