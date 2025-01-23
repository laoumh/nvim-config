--[[ LSP
DOCS:
Instalação:
  - `:MasonInstall html-lsp`
--]]

local capabilities = require('utils.extend-capabilities')
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').html.setup({
  capabilities = capabilities,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = false,
  },
})

require("luasnip").filetype_extend("htmldjango", { "html" })
