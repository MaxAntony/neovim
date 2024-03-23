return {
  {
    'neovim/nvim-lspconfig',

    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = true,
      },
      ---@type lspconfig.options
      servers = {
        -- https://www.npmjs.com/package/typescript-language-server , mason for more details
        tsserver = {
          single_file_support = false,
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              referencesCodeLens = { enabled = true, showOnAllFunctions = true },
              implementationsCodeLens = { enabled = true },
              autoClosingTags = true,
              preferGoToSourceDefinition = true,
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterTypes = { enabled = true },
                parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = true,
                },

                -- don't work raise issue at mason in schema tsserver
                -- enumMemberValues = { enabled = true },
                -- functionLikeReturnTypes = { enabled = true },
                -- parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                -- parameterTypes = { enabled = true },
                -- propertyDeclarationTypes = { enabled = true },
                -- variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },

                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
                setType = true,
                arrayIndex = 'Auto',
                paramName = 'All',
                paramType = true,
              },
            },
          },
        },
        denols = {
          single_file_support = false,
          settings = {
            deno = {
              inlayHints = {
                variableTypes = { enabled = true },
                parameterNames = { enabled = 'all' },
                parameterTypes = { enabled = true },
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
              },
              enable = true,
              suggest = {
                imports = {
                  hosts = {
                    ['https://crux.land'] = true,
                    ['https://deno.land'] = true,
                    ['https://x.nest.land'] = true,
                  },
                },
              },
            },
          },
        },
      },
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
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'elgiano/nvim-treesitter-angular', branch = 'topic/jsx-fix' },
    opts = {
      rainbow = {
        enable = true,
        query = { 'rainbow-parens', html = 'rainbow-tags' },
        extended_mode = true,
        max_file_lines = nil,
      },
      -- nvim-ts-autotag
      autotag = {
        enable_close_on_slash = false,
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    -- version = '3.14',
    opts = {
      close_if_last_window = true,
      window = {
        auto_expand_width = true,
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(file_path)
            --auto close
            require('neo-tree.sources.manager').close_all()
          end,
        },
      },
    },
  },
  { 'folke/tokyonight.nvim', opts = { style = 'storm' } },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      {
        '<leader>fB',
        "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>",
        desc = 'last buffers',
      },
    },
  },
  {
    'echasnovski/mini.animate',
    opts = { resize = { enable = false } },
  },
  -- override nvim-cmp
  {
    'hrsh7th/nvim-cmp',
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require('cmp')
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    config = function()
      require('dashboard').setup({
        hide = {
          -- NOTE: added this to fix no lualine in buffers
          statusline = false,
        },
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
  },
}
