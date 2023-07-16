return {
  'kevinhwang91/nvim-ufo',
  event = 'BufRead',
  keys = {
    {
      'zR',
      function() require('ufo').openAllFolds() end,
    },
    {
      'zM',
      function() require('ufo').closeAllFolds() end,
    },
  },
  dependencies = {
    'neovim/nvim-lspconfig',
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require('statuscol.builtin')
        require('statuscol').setup({
          relculright = true,
          segments = {
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
            { text = { ' ', builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
          },
        })
      end,
    },
  },
  opts = function(_, opts)
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- advanced config https://github.com/kevinhwang91/nvim-ufo/blob/main/doc/example.lua line 26
    local ftMap = {
      vim = 'indent',
      python = { 'indent' },
      git = '',
      NvimTree = '',
      Telescope = '',
      ToggleTerm = '',
      dashboard = '',
      startup = '',
      ['neo-tree'] = '',
      ['neo-tree-popup'] = '',
      notify = '',
      terminal = '',
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
        :catch(function(err) return handleFallbackException(err, 'treesitter') end)
        :catch(function(err) return handleFallbackException(err, 'indent') end)
    end

    opts.close_fold_kinds = { 'imports', 'comment' }
    opts.provider_selector = function(bufnr, filetype, buftype) return ftMap[filetype] or customizeSelector end

    -- return {
    -- provider_selector = function(bufnr, filetype, buftype)
    --   return ftMap[filetype] or customizeSelector
    -- end,
    -- }
  end,
}
