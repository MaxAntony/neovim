return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  opts = {
    ensure_installed = {
      'stylua',
      'cspell',
      -- "flake8",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require('mason').setup(opts)
    local mr = require('mason-registry')
    mr:on('package:install:success', function(pkg)
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require('lazy.core.handler.event').trigger({
          event = 'FileType',
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)

      if pkg.name == 'cspell' then
        -- install and link ES dict for cspell
        local cwd = vim.fn.stdpath('data') .. '/mason/packages/cspell'
        local job = require('plenary.job')
        local action_name = 'cspell ES dict'

        job
          :new({
            command = 'npm',
            args = { 'i', '@cspell/dict-es-es' },
            cwd = cwd,
            on_start = function() vim.notify('Installing ' .. action_name) end,
            on_exit = function()
              vim.notify('Finished installing ' .. action_name)
              job
                :new({
                  command = 'npx',
                  args = { 'cspell', 'link', 'add', '@cspell/dict-es-es' },
                  cwd = cwd,
                  on_start = function() vim.notify('Linking ' .. action_name) end,
                  on_exit = function() vim.notify('Finished linking ' .. action_name) end,
                  on_stderr = function() vim.notify('Error linking ' .. action_name) end,
                })
                :start()
            end,
            on_stderr = function() vim.notify('Error installing ' .. action_name) end,
          })
          :start()
      end
    end)
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
