return {
  {
    "neovim/nvim-lspconfig",

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        tsserver = {
          single_file_support = false,
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              -- Schemas https://www.schemastore.org
              schemas = {
                {
                  fileMatch = { "package.json" },
                  url = "https://json.schemastore.org/package.json",
                },
                {
                  fileMatch = { "tsconfig*.json" },
                  url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                  fileMatch = { "deno.json", "deno.jsonc" },
                  url = "https://deno.land/x/deno@v1.30.3/cli/schemas/config-file.v1.json",
                },
                {
                  fileMatch = {
                    ".prettierrc",
                    ".prettierrc.json",
                    "prettier.config.json",
                  },
                  url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                  fileMatch = { ".eslintrc", ".eslintrc.json" },
                  url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                  fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
                  url = "https://json.schemastore.org/babelrc.json",
                },
                {
                  fileMatch = { "lerna.json" },
                  url = "https://json.schemastore.org/lerna.json",
                },
                {
                  fileMatch = { "now.json", "vercel.json" },
                  url = "https://json.schemastore.org/now.json",
                },
                {
                  fileMatch = {
                    ".stylelintrc",
                    ".stylelintrc.json",
                    "stylelint.config.json",
                  },
                  url = "http://json.schemastore.org/stylelintrc.json",
                },
                {
                  fileMatch = { ".cspell.json", "cspell.json" },
                  url = "https://raw.githubusercontent.com/streetsidesoftware/cspell/main/cspell.schema.json",
                },
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
                arrayIndex = "Auto",
                paramName = "All",
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
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
              },
              enable = true,
              suggest = {
                imports = {
                  hosts = {
                    ["https://crux.land"] = true,
                    ["https://deno.land"] = true,
                    ["https://x.nest.land"] = true,
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
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            --auto close
            require("neo-tree").close_all()
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      rainbow = {
        enable = true,
        query = { "rainbow-parens", html = "rainbow-tags" },
        extended_mode = true,
        max_file_lines = nil,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- remove when neo-tree update to nerdfonts v3
      -- for detect obsolete font icons you can use Nerdfix https://github.com/loichyan/nerdfix
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        git_status = {
          symbols = {
            renamed = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = "󰠄 ", hl = "Function" },
        },
      },
      -- Add this section only if you've configured source selector.
      source_selector = {
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
    },
  },
}
