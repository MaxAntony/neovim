local M = {}
function M.setup()
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
  require('null-ls').setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
    sources = {
      -- install from mason
      require("null-ls").builtins.formatting.prettier,
      -- fix npm i -g eslint
      require("null-ls").builtins.diagnostics.eslint,
    }
  })
end

return M
