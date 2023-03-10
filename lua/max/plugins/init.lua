require('lazy').setup({
  'folke/which-key.nvim',

  'folke/neodev.nvim',
  'voldikss/vim-floaterm',
  'tpope/vim-fugitive',
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'navarasu/onedark.nvim',
    config = function()
      require('max.plugins.onedark').setup()
    end,
  },
  {
    'williamboman/mason.nvim',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
  },
  -- {
  --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   dependencies = { 'williamboman/mason.nvim' },
  --   config = function()
  --     require('max.plugins.mason-tool-installer').setup()
  --   end,
  -- },
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
  --    https://github.com/mrjones2014/nvim-ts-rainbow
  -- { 'p00f/nvim-ts-rainbow', dependencies = 'nvim-treesitter/nvim-treesitter' },
  -- esta libreria no colorea bien el html y jsx, abrir un issue por que la libreria implemente la funcion anterior
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
    dependencies = { 'kyazdani42/nvim-web-devicons' },
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
      require('which-key').setup({})
    end,
  },

  -- {
  -- 'iamcco/markdown-preview.nvim',
  --  cmd = function()
  --        vim.fn['mkdp#util#install']()
  -- end,
  -- build = function()
  --   vim.g.mkdp_filetypes = { 'markdown' }
  -- end,
  --ft = { 'markdown' },
  --},

  -- UI
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- https://github.com/EdenEast/nightfox.nvim tema interesante
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
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
    'j-hui/fidget.nvim',
    dependencies = { 'lualine.nvim' },
    config = function()
      require('fidget').setup({})
    end,
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    config = function()
      require('lsp-inlayhints').setup()
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
    end,
  },
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      require('statuscol').setup({ foldfunc = 'builtin', setopt = true })
    end,
  },
})
