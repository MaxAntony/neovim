require('lazy').setup({
  'folke/neodev.nvim',
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup()
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup({
        direction = 'float',
      })
    end,
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },
  -- {
  --   'mrded/nvim-lsp-notify',
  --   config = function()
  --     require('lsp-notify').setup({})
  --   end,
  --   dependencies = { 'rcarriga/nvim-notify' },
  --   lazy = false,
  -- },
  {
    'j-hui/fidget.nvim',
    dependencies = { 'lualine.nvim' },
    config = function()
      require('fidget').setup({})
    end,
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
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
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  -- {
  --   'startup-nvim/startup.nvim',
  --   dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'folke/tokyonight.nvim' },
  --   config = function()
  --     require('startup').setup({ theme = 'startify' })
  --   end,
  --   lazy = false,
  -- },
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = '1.2.*',
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
  },
  -- # UI theme
  -- ===========================================
  --[[ {
    'navarasu/onedark.nvim',
    config = function()
      require('max.plugins.onedark').setup()
    end,
  }, ]]
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('max.plugins.gruvbox').setup(false)
    end,
  },
  {
    'folke/tokyonight.nvim',
    config = function()
      require('max.plugins.tokyonight').setup(true)
    end,
    lazy = false,
    priority = 1000,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    config = function()
      require('no-neck-pain').setup({
        width = 150,
      })
    end,
  },
  -- =========================================
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
      })
      require('lsp_lines').setup()
    end,
  },
  {
    'williamboman/mason.nvim',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('max.plugins.mason-tool-installer').setup()
    end,
  },
  {
    'dmmulroy/tsc.nvim',
    config = function()
      require('tsc').setup()
    end,
  },
  -- {
  --   'kkoomen/vim-doge',
  --   build = ':call doge#install()',
  --   config = function()
  --     vim.cmd([[ let g:doge_javascript_settings = { 'destructuring_props': 1, 'omit_redundant_param_types': 0 } ]])
  --   end,
  -- },
  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('max.plugins.nvim-lspconfig').setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind.nvim',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('max.plugins.nvim-cmp').setup()
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('max.plugins.null-ls').setup()
    end,
  },

  -- UTILS
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    config = function()
      require('max.plugins.lsp-inlayhints').setup()
    end,
    commit = '0948ecb',
  },
  -- { 'mrjones2014/nvim-ts-rainbow' },
  -- esta librería no colorea bien el html y jsx, abrir un issue por que la librería implemente la función anterior
  -- solución html: https://github.com/HiPhish/nvim-ts-rainbow2/issues/18#issuecomment-1498400902
  -- entrar a los archivos del plugin y modificar los .scm correspondientes
  { 'https://gitlab.com/HiPhish/nvim-ts-rainbow2', dependencies = 'nvim-treesitter/nvim-treesitter' },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('max.plugins.nvim-treesitter').setup()
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly',
    config = function()
      require('max.plugins.nvim-tree').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      -- ts_context_commentstring: https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' } },
    config = function()
      require('max.plugins.nvim-telescope').setup()
      -- require("telescope").load_extension("fzf")
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      require('which-key').setup({})
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- https://github.com/EdenEast/nightfox.nvim tema interesante
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('max.plugins.lualine').setup()
    end,
  },
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('max.plugins.neoscroll').setup()
    end,
  },

  {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup({})
    end,
  },
  {
    'rrethy/vim-illuminate',
    dependencies = 'nvim-lspconfig',
    config = function()
      require('illuminate').configure({
        filetypes_denylist = {
          'NvimTree',
          'floaterm',
        },
      })
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('max.plugins.nvim-colorizer').setup()
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('max.plugins.hlslens').setup()
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = { 'kevinhwang91/nvim-hlslens' },
    config = function()
      require('max.plugins.nvim-scrollbar').setup()
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        use_treesitter = true,
        show_trailing_blankline_indent = false,
        -- show_current_context_start = true
      })
      -- https://github.com/lukas-reineke/indent-blankline.nvim/issues/566
      vim.g.indent_blankline_filetype_exclude =
        { 'dashboard', 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'NvimTree' }
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require('statuscol.builtin')
          require('statuscol').setup({
            relculright = true,
            segments = {
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
              { text = { ' ', builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
            },
          })
        end,
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
})
