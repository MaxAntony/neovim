return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
            { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          },
        })
      end,
    },
  },
  event = "BufReadPost",
  opts = function()
    -- advanced config https://github.com/kevinhwang91/nvim-ufo/blob/main/doc/example.lua line 26
    local ftMap = {
      vim = "indent",
      python = { "indent" },
      git = "",
      NvimTree = "",
      Telescope = "",
      ToggleTerm = "",
      dashboard = "",
      startup = "",
    }

    local function customizeSelector(bufnr)
      local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return require("ufo").getFolds(bufnr, providerName)
        else
          return require("promise").reject(err)
        end
      end

      return require("ufo")
        .getFolds(bufnr, "lsp")
        :catch(function(err)
          return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
          return handleFallbackException(err, "indent")
        end)
    end

    return {
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype] or customizeSelector
      end,
    }
  end,
  init = function()
    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", function()
      require("ufo").openAllFolds()
    end)
    vim.keymap.set("n", "zM", function()
      require("ufo").closeAllFolds()
    end)
  end,
}
