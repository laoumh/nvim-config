--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall html-lsp`
--]]
require('lspconfig').html.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
