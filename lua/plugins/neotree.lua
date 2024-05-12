return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  -- version = '3.14',
  opts = {
    close_if_last_window = true,
    window = {
      auto_expand_width = true,
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(file_path)
          --auto close
          require('neo-tree.sources.manager').close_all()
        end,
      },
    },
  },
}
