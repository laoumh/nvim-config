--[[ LSP
DOCS:
Instalar lua-language-server:
  - `:MasonInstall lua-language-server`
  - Ver https://luals.github.io/wiki/settings/

--]]
require('lspconfig').lua_ls.setup({
  capabilities = require("utils.extend-capabilities"),
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      -- ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
})
