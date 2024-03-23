return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'davidmh/cspell.nvim' },
  config = function()
    local null_ls = require('null-ls')
    local cspell = require('cspell')

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local builtins = require('null-ls').builtins

    null_ls.setup({
      sources = {
        -- builtins.formatting.prettier,
        builtins.formatting.prettierd,
        -- install from mason prettierd
        -- fix npm i -g eslint
        --[[ builtins.diagnostics.eslint.with({
          condition = function(utils) return utils.root_has_file('.eslint.json') or utils.root_has_file('.eslintrc.js') end,
        }), ]]
        --[[ builtins.code_actions.eslint.with({
          condition = function(utils) return utils.root_has_file('.eslint.json') or utils.root_has_file('.eslintrc.js') end,
        }), ]]
        -- http://cspell.org/
        -- si no lanza revisar si se tiene custom-words.txt o ejecutarlo en la terminar y ver el resultado
        -- agregar diccionario español https://github.com/streetsidesoftware/cspell-dicts/tree/main/dictionaries/es_ES#readme
        cspell.diagnostics.with({
          disabled_filetypes = { 'NvimTree', 'floaterm' },
          condition = function(utils) return utils.root_has_file({ '.cspell.json' }) end,
          -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#diagnostics-postprocess
          diagnostics_postprocess = function(diagnostics) diagnostics.severity = vim.diagnostic.severity['WARN'] end,
          -- disabled_filetypes = { "NvimTree", "floaterm" },
        }),
        cspell.code_actions.with({
          condition = function(utils) return utils.root_has_file({ '.cspell.json' }) end,
        }),
        -- https://github.com/JohnnyMorganz/StyLua
        builtins.formatting.stylua,
        -- builtins.diagnostics.todo_comments,
      },

      on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(client) return client.name == 'null-ls' end,
              })
            end,
          })
        end
      end,
    })
  end,
}
