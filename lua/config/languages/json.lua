--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall json-lsp`
--]]

--Enable (broadcasting) snippet capability for completion
local capabilities = require('utils.extend-capabilities')
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}
