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
    -- LSP
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'j-hui/fidget.nvim'
      }
    }
    use {
      'williamboman/mason.nvim',
      config = function()
        require 'mason'.setup()
      end
    }
    use {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require 'mason-lspconfig'.setup()
      end
    }
    use {
      'lukas-reineke/lsp-format.nvim',
      config = function()
        require 'lsp-format'.setup()
      end
    }
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        'onsails/lspkind.nvim',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
      },
      config = function()
        require 'max.plugins.nvim-cmp'.setup()
      end
    }
    use "folke/lua-dev.nvim"

    -- UTILS
    use 'jiangmiao/auto-pairs'
    use 'voldikss/vim-floaterm'
    use 'p00f/nvim-ts-rainbow'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      config = function()
        require 'nvim-treesitter.configs'.setup {
          ensure_installed = { "tsx", "lua", "typescript", "python", "graphql", "json", "jsdoc", "json5", "markdown",
            "prisma", "javascript" },
          auto_install = true,
          highlight = { enable = true },
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil
          }
        }
      end
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      tag = 'nightly',
      config = function()
        require 'max.plugins.nvim-tree'.setup()
      end
    }
    use {
      'numToStr/Comment.nvim',
      config = function()
        require 'Comment'.setup()
      end
    }
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      -- or                            , branch = '0.1.x',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require 'telescope'.setup {}
        require('telescope').load_extension('fzf')
      end
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


    -- UI
    use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('bufferline').setup()
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require 'gitsigns'.setup()
      end
    }
    use {
      'navarasu/onedark.nvim',
      config = function()
        require 'max.plugins.onedark'.setup()
      end
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require 'max.plugins.lualine'.setup()
      end
    }
    use {
      'karb94/neoscroll.nvim',
      config = function()
        require 'max.plugins.neoscroll'.setup()
      end
    }
    use {
      'Xuyuanp/scrollbar.nvim',
      config = function()
        require 'max.plugins.scrollbar'.setup()
      end
    }
    use {
      'j-hui/fidget.nvim',
      after = 'lualine.nvim',
      config = function()
        require 'fidget'.setup {}
      end
    }
    use {
      'lvimuser/lsp-inlayhints.nvim',
      config = function()
        require 'lsp-inlayhints'.setup()
      end
    }
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