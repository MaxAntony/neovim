-- revisar https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
local M = {}
function M.setup()
  local wk = require('which-key')

  require('mason').setup()
  require('mason-lspconfig').setup({
    automatic_installation = true,
  })

  local languages = {
    'pyright',
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
  wk.register({
    ['<space>m'] = { ':lua vim.diagnostic.open_float()<cr>', 'diagnostic open float' },
    [']d'] = { ':lua vim.diagnostic.goto_prev()<cr>', 'diagnostic go to prev' },
    ['[d'] = { ':lua vim.diagnostic.goto_next()<cr>', 'diagnostic go to next' },
  }, { mode = 'n' })
  -- commented by conflict  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- illuminate plugin config for highlight instead of underline
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    wk.register({
      g = {
        name = 'lsp utils',
        d = { ':Telescope lsp_definitions<cr>', 'definitions' },
        r = { ':Telescope lsp_references<cr>', 'references' },
        i = { ':lua vim.lsp.buf.implementation()<cr>', 'implementations' },
        D = { ':lua vim.lsp.buf.declaration()<cr>', 'declarations' },
      },
      K = { ':lua vim.lsp.buf.hover()<cr>', 'hover' },
      ['<space>'] = {
        rn = { ':lua vim.lsp.buf.rename()<cr>', 'lsp rename' },
        ca = { ':lua vim.lsp.buf.code_action()<cr>', 'lsp code actions' },
        D = { ':lua vim.lsp.buf.type_definition()<cr>', 'lsp type definition' },
      },
      ['<C-k>'] = { ':lua vim.lsp.buf.signature_help()<cr>', 'lsp signature help' },
    }, { mode = 'n', buffer = bufnr })
    -- the same as above but the window for select the correct definition closes after select
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
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
  for _, lang in ipairs(languages) do
    lsp[lang].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    if lang == 'tailwindcss' then
      lsp[lang].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            -- custom "Styles" for completion in declarations like `let sizeStyles = "intellisense here working"`
            -- https://github.com/tailwindlabs/tailwindcss/discussions/7554
            -- https://kimmo.blog/posts/6-advanced-typescript-the-ultimate-tailwind-typings/
            classAttributes = { 'class', 'className', 'ngClass', '.*Styles*' },
          },
        },
      })
    end
  end

  require('neodev').setup({})
  lsp.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
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

  local function organize_imports()
    local params = {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(0) },
      title = '',
    }
    vim.lsp.buf.execute_command(params)
  end

  -- https://github.com/lvimuser/lsp-inlayhints.nvim#configuration
  -- https://github.com/jose-elias-alvarez/typescript.nvim
  -- https://www.reddit.com/r/neovim/comments/107r1qw/sort_imports/
  -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
  -- https://www.reddit.com/r/neovim/comments/lwz8l7/how_to_use_tsservers_organize_imports_with_nvim/
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
    commands = {
      OrganizeImports = {
        organize_imports,
        description = 'Organize Imports',
      },
    },
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

  -- UFO folding
  local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = '',
    NvimTree = '',
    Telescope = '',
    ToggleTerm = '',
    dashboard = '',
    startup = '',
  }

  local function customizeSelector(bufnr)
    local function handleFallbackException(err, providerName)
      if type(err) == 'string' and err:match('UfoFallbackException') then
        return require('ufo').getFolds(bufnr, providerName)
      else
        return require('promise').reject(err)
      end
    end

    return require('ufo')
      .getFolds(bufnr, 'lsp')
      :catch(function(err)
        return handleFallbackException(err, 'treesitter')
      end)
      :catch(function(err)
        return handleFallbackException(err, 'indent')
      end)
  end

  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
      return ftMap[filetype] or customizeSelector
    end,
  })
  -- end UFO folding
end

return M
