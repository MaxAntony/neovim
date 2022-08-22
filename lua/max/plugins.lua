local M = {}

function M.setup()
  --indicate first time installation
  local packer_bootstrap = false

  local conf = {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    }
  }

  -- check if packer.nvim is installed
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    -- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
      pattern = 'plugins.lua',
      command = 'source <afile> | PackerCompile',
    })
  end

  -- Plugins
  local function plugins(use)
    use 'wbthomason/packer.nvim' --package manager
  end

  if packer_bootstrap then
    print 'Restart nvim required after installation!'
    require 'packer'.sync()
  end

  packer_init()

  local packer = require 'packer'


  packer.init(conf)
  packer.startup(plugins)
end

return M
