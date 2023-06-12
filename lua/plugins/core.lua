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
}
