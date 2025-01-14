--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall css-lsp`
--]]
require('lspconfig').cssls.setup({
  capabilities = require('utils.extend-capabilities'),
})
