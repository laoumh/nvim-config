--[[
DOCS:
- Necessário ter Golang instalado: https://go.dev/doc/install
- LSP: Instalar `gopls`
--]]

-- LSP
require('lspconfig').gopls.setup({
  capabilities = require('utils.extend-capabilities'),
})

