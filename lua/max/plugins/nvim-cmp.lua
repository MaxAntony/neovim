local M = {}
function M.setup()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    --  window = {
    --  completion = {
    --      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:Pmenu",
    --  col_offset = -3,
    --side_padding = 0,
    -- }
    --},
    formatting = {
      --  fields = { 'kind', 'abbr', 'menu' },
      format = lspkind.cmp_format(),
      --format = function(entry, vim_item)
      --local kind = lspkind.cmp_format({
      --mode = 'symbol_text',
      --maxwidth = 50
      --})(entry, vim_item)
      --local strings = vim.split(kind.kind, '%s', { trimempty = true })
      --kind.kind = " " .. strings[1] .. " "
      --kind.menu = "    (" .. strings[2] .. ")"

      --return kind
      --end,
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  })
end

return M
