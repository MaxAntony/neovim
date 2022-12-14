local M = {}

function M.setup()
  --indicate first time installation
  local packer_bootstrap = false

  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  -- check if packer.nvim is installed
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      })
      vim.cmd([[packadd packer.nvim]])
    end
    -- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
      pattern = "plugins/init.lua",
      command = "source <afile> | PackerCompile",
    })
  end

  -- Plugins
  local function plugins(use)
    use("wbthomason/packer.nvim") --package manager

    -- LSP
    use({
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    })
    use({
      "williamboman/mason-lspconfig.nvim",
      requires = { "mason.nvim" },
      config = function()
        require("mason-lspconfig").setup({
          automatic_installation = true,
        })
      end,
    })
    use({
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      requires = { "mason.nvim" },
      config = function()
        require("max.plugins.mason-tool-installer").setup()
      end,
    })
    use({
      "neovim/nvim-lspconfig",
      requires = {
        "j-hui/fidget.nvim",
      },
      config = function()
        require("max.plugins.nvim-lspconfig").setup()
      end,
    })
    use({
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("max.plugins.nvim-cmp").setup()
      end,
    })
    use("folke/neodev.nvim")
    use({
      "jose-elias-alvarez/null-ls.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("max.plugins.null-ls").setup()
      end,
    })

    -- UTILS
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup({})
      end,
    })
    use({
      "kevinhwang91/nvim-ufo",
      requires = { "kevinhwang91/promise-async", 'nvim-treesitter/nvim-treesitter' },
      config = function()
        -- https://github.com/kevinhwang91/nvim-ufo/issues/4
        require("ufo").setup({
          provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
          end
        })
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
      end,
    })
    use("voldikss/vim-floaterm")
    use({ "p00f/nvim-ts-rainbow", requires = "nvim-treesitter" })
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("max.plugins.nvim-treesitter").setup()
      end,
    })
    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      tag = "nightly",
      config = function()
        require("max.plugins.nvim-tree").setup()
      end,
    })
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use({
      "numToStr/Comment.nvim",
      config = function()
        -- ts_context_commentstring: https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
        require("Comment").setup({
          pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
      end,
    })

    use({
      "nvim-telescope/telescope.nvim",
      tag = "0.1.0",
      -- or                            , branch = '0.1.x',
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("max.plugins.nvim-telescope").setup()
        require("telescope").load_extension("fzf")
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end,
    })
    use({
      "tpope/vim-fugitive",
    })
    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    })

    -- UI
    --[[     use {
      'akinsho/bufferline.nvim',
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
        require('bufferline').setup()
      end
    } ]]
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup()
      end,
    })
    -- https://github.com/EdenEast/nightfox.nvim tema interesante
    use({
      "navarasu/onedark.nvim",
      config = function()
        require("max.plugins.onedark").setup()
      end,
    })
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "navarasu/onedark.nvim" },
      config = function()
        require("max.plugins.lualine").setup()
      end,
    })
    use({
      "karb94/neoscroll.nvim",
      config = function()
        require("max.plugins.neoscroll").setup()
      end,
    })
    use({
      "j-hui/fidget.nvim",
      after = "lualine.nvim",
      config = function()
        require("fidget").setup({})
      end,
    })
    use({
      "lvimuser/lsp-inlayhints.nvim",
      config = function()
        require("lsp-inlayhints").setup()
      end,
    })
    use({
      "anuvyklack/pretty-fold.nvim",
      config = function()
        require("pretty-fold").setup({})
      end,
    })
    use({
      "rrethy/vim-illuminate",
      requires = "nvim-lspconfig",
      config = function()
        require("illuminate").configure({
          filetypes_denylist = {
            "NvimTree",
            "floaterm",
          },
        })
      end,
    })
    use({
      "NvChad/nvim-colorizer.lua",
      config = function()
        require("max.plugins.nvim-colorizer").setup()
      end,
    })
    use({
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("max.plugins.hlslens").setup()
      end,
    })
    use({
      "petertriho/nvim-scrollbar",
      requires = { "kevinhwang91/nvim-hlslens" },
      config = function()
        require("max.plugins.nvim-scrollbar").setup()
      end,
    })

    use { "lukas-reineke/indent-blankline.nvim", config = function()
      require('indent_blankline').setup {
        show_current_context = true,
        use_treesitter = true,
        show_trailing_blankline_indent = false,
        -- show_current_context_start = true
      }
    end }
  end

  if packer_bootstrap then
    print("Restart nvim required after installation!")
    require("packer").sync()
  end

  packer_init()

  local packer = require("packer")

  packer.init(conf)
  packer.startup(plugins)
end

return M
