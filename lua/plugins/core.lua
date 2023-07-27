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
              preferGoToSourceDefinition = true,
              inlayHints = {
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
    opts = {
      rainbow = {
        enable = true,
        query = { 'rainbow-parens', html = 'rainbow-tags' },
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
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
}
