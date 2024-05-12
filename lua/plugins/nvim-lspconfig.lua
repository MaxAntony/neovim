return {
  'neovim/nvim-lspconfig',

  ---@param _ LazyPlugin
  ---@param opts PluginLspOpts
  opts = function(_, opts)
    local mason_registry = require('mason-registry')
    local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
    -- Vue config ( must be before opts = { )
    opts.servers.tsserver.init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vue_language_server_path,
          languages = { 'vue' },
        },
      },
    }
    opts.servers.tsserver.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    -- End Vue config

    opts.inlay_hints.enabled = true

    local aditionalConfig = {

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
              -- referencesCodeLens = { enabled = true, showOnAllFunctions = true },
              -- implementationsCodeLens = { enabled = true },
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
    }

    local mergedOpts = vim.tbl_deep_extend('force', opts, aditionalConfig)
    return mergedOpts
  end,
}
