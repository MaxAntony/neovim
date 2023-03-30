-- revisar https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
local M = {}
function M.setup()
  require('mason').setup()
  require('mason-lspconfig').setup({
    automatic_installation = true,
  })

  local languages = {
    'graphql',
    'prismals',
    'tailwindcss',
    'angularls',
    'cssls',
    'bashls',
    'dockerls',
    'html',
    'gopls',
    'docker_compose_language_service',
  }

  -- icons to the left bar
  local signs = {
    { name = 'DiagnosticSignError', text = ' ' },
    { name = 'DiagnosticSignWarn', text = ' ' },
    { name = 'DiagnosticSignInfo', text = ' ' },
    { name = 'DiagnosticSignHint', text = ' ' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<Leader>m', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  -- commented by conflict  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- illuminate plugin config for highlight instead of underline
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })

    -- Enable completion triggered by <c-x><c-o>
    require('lsp-inlayhints').on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<cr>', bufopts)
    -- the same as above but the window for select the correct definition closes after select
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    --[[ vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts) ]]
  end

  local lsp = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- for ufo plugin
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  -- end

  require('neodev').setup({})
  lsp.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        format = {
          enable = true,
          -- Put format options here
          -- NOTE: the value should be STRING!!
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
          },
        },
        hint = {
          enable = true,
          setType = true,
          arrayIndex = 'auto',
          paramName = 'all',
          paramType = true,
        },
      },
    },
  })

  for _, lang in ipairs(languages) do
    -- for angular install @angular/language-server as dev dependency in your project
    lsp[lang].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  lsp['pyright'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  local denols_root_files = {
    'deno.json',
    'deno.jsonc',
  }
  lsp['denols'].setup({
    root_dir = function(fname)
      local primary = lsp.util.root_pattern(unpack(denols_root_files))(fname)
      return primary
    end,
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = false,
    settings = {
      settings = {
        deno = {
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
    -- settings = {
    --   deno = {
    --     inlayHints = {
    --       enumMemberValues = true,
    --     },
    --   },
    -- },
  })

  local tsserver_root_files = {
    'package.json',
    'package-lock.json',
    'tsconfig.json',
  }
  lsp['tsserver'].setup({
    root_dir = function(fname)
      local primary = lsp.util.root_pattern(unpack(tsserver_root_files))(fname)
      return primary
    end,
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = false,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
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
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  })

  lsp['rust_analyzer'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    -- Server-specific settings...
    settings = {
      ['rust-analyzer'] = {},
    },
  })

  lsp['jsonls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        -- Schemas https://www.schemastore.org
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'tsconfig*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = { 'deno.json', 'deno.jsonc' },
            url = 'https://deno.land/x/deno@v1.30.3/cli/schemas/config-file.v1.json',
          },
          {
            fileMatch = {
              '.prettierrc',
              '.prettierrc.json',
              'prettier.config.json',
            },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { 'lerna.json' },
            url = 'https://json.schemastore.org/lerna.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = {
              '.stylelintrc',
              '.stylelintrc.json',
              'stylelint.config.json',
            },
            url = 'http://json.schemastore.org/stylelintrc.json',
          },
          {
            fileMatch = { '.cspell.json', 'cspell.json' },
            url = 'https://raw.githubusercontent.com/streetsidesoftware/cspell/main/cspell.schema.json',
          },
        },
      },
    },
  })

  require('ufo').setup()
end

return M
