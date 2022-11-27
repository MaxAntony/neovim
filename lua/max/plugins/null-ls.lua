local M = {}
function M.setup()
  local null_ls = require("null-ls")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    sources = {
      -- install from mason
      require("null-ls").builtins.formatting.prettier,
      -- fix npm i -g eslint
      require("null-ls").builtins.diagnostics.eslint.with({
        condition = function(utils)
          return utils.root_has_file({ "package.json" })
        end,
      }),
      -- http://cspell.org/
      require("null-ls").builtins.diagnostics.cspell.with({
        disabled_filetypes = { "NvimTree", "floaterm" },
        condition = function(utils)
          return utils.root_has_file({ ".cspell.json" })
        end,
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#diagnostics-postprocess
        diagnostics_postprocess = function(diagnostics)
          diagnostics.severity = vim.diagnostic.severity["WARN"]
        end,
        -- disabled_filetypes = { "NvimTree", "floaterm" },
      }),
      require("null-ls").builtins.code_actions.cspell.with({
        condition = function(utils)
          return utils.root_has_file({ ".cspell.json" })
        end,
      }),
      -- https://github.com/JohnnyMorganz/StyLua
      require("null-ls").builtins.formatting.stylua,
    },

    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              --[[ 							filter = function(cl)
								return cl.name == "null-ls"
							end, ]]
            })
          end,
        })
      end
    end,
  })
end

return M
