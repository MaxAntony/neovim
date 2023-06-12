return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            -- UFO folding
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            --auto close
            require("neo-tree").close_all()
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      rainbow = {
        enable = true,
        query = { "rainbow-parens", html = "rainbow-tags" },
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
}
