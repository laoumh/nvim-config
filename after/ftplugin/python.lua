--[[ LSP
DOCS:
Instalar python-lsp-server:
  - `:MasonInstall python-lsp-server`
  - Ou usando pip
  - Ver https://github.com/python-lsp/python-lsp-server

--]]
require('lspconfig').pylsp.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

