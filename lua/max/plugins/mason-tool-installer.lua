local M = {}

function M.setup()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "angular-language-server",
      "bash-language-server",
      "cspell",
      "css-lsp",
      "deno",
      "dockerfile-language-server",
      "eslint_d",
      "graphql-language-service-cli",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      "nginx-language-server",
      "prettier",
      "prisma-language-server",
      "pyright",
      "rust-analyzer",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
    },
    start_delay = 3000,
  })
end

return M
