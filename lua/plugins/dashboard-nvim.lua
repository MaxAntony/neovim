-- return {
--   'nvimdev/dashboard-nvim',
--   lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
--   opts = function()
--     local opts = {
--       theme = 'hyper',
--       hide = {
--         -- this is taken care of by lualine
--         -- enabling this messes up the actual laststatus setting after loading a file
--         statusline = false,
--       },
--       config = {
--         -- stylua: ignore
--         week_header={enable=true},
--         -- center = {
--         --   { action = LazyVim.telescope('files'), desc = ' Find File', icon = ' ', key = 'f' },
--         --   { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
--         --   { action = 'Telescope oldfiles', desc = ' Recent Files', icon = ' ', key = 'r' },
--         --   { action = 'Telescope live_grep', desc = ' Find Text', icon = ' ', key = 'g' },
--         --   { action = [[lua LazyVim.telescope.config_files()()]], desc = ' Config', icon = ' ', key = 'c' },
--         --   { action = 'lua require("persistence").load()', desc = ' Restore Session', icon = ' ', key = 's' },
--         --   { action = 'LazyExtras', desc = ' Lazy Extras', icon = ' ', key = 'x' },
--         --   { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
--         --   { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
--         -- },
--         packages = { enabled = true },
--
--         footer = function()
--           local stats = require('lazy').stats()
--           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--           return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
--         end,
--       },
--     }
--
--     -- for _, button in ipairs(opts.config.center) do
--     --   button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
--     --   button.key_format = '  %s'
--     -- end
--
--     -- close Lazy and re-open when the dashboard is ready
--     if vim.o.filetype == 'lazy' then
--       vim.cmd.close()
--       vim.api.nvim_create_autocmd('User', {
--         pattern = 'DashboardLoaded',
--         callback = function() require('lazy').show() end,
--       })
--     end
--
--     return opts
--   end,
-- }
--
return {
  'nvimdev/dashboard-nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  opts = {
    theme = 'hyper',
    config = {
      week_header = { enable = true },
      packages = { enable = true },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
      },
    },
  },
}
