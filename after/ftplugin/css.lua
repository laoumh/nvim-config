--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall css-lsp`
--]]
require('lspconfig').cssls.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
