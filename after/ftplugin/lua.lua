--[[ CONFIG ]]
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

--[[ LSP
DOCS:
Instalar lua-language-server:
  - `:MasonInstall lua-language-server`
  - Ver https://luals.github.io/wiki/settings/

--]]
require('lspconfig').lua_ls.setup({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
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

