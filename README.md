## Plugins interesantes

- nvim-spectre
- typescript-tools.nvim

## Lectura

- [rewrite vimrc in lua](https://medium.com/@sugetatomo/a-journey-to-rewriting-vimrc-in-lua-for-the-first-time-all-done-with-lua-c4787e895b53)

## Parches

### nvim-ufo

en `lua/ufo/provider/lsp/nvim.lua` en la función getClients agregar la linea en la condicional antes que haga return true

```lua
if client.name == 'angularls' then return false end
```
