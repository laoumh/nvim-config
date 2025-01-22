--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall html-lsp`
--]]
require('lspconfig').html.setup({
  capabilities = require('utils.extend-capabilities'),
})

require("luasnip").filetype_extend("htmldjango", { "html" })
