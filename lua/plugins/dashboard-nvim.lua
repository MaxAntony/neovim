return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      hide = {
        -- NOTE: added this to fix no lualine in buffers
        statusline = false,
      },
      theme = "hyper",
      config = {
        week_header = { enable = true },
        packages = { enable = true },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
