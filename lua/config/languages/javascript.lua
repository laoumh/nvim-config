--[[ LSP
DOCS:
  - https://github.com/typescript-language-server/typescript-language-server
  - https://eslint.org/docs/latest/use/integrations#editors

--]]
require('lspconfig').ts_ls.setup({
  capabilities = require('utils.extend-capabilities'),
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
})

--[[ Linter
WARN:
ESLint precisa estar instalado no projeto (local ou global)

--]]
require('lint').linters_by_ft['javascript'] = { 'eslint_d' }
require('lint').linters_by_ft['javascriptreact'] = { 'eslint_d' }
require('lint').linters_by_ft['typescript'] = { 'eslint_d' }
require('lint').linters_by_ft['typescriptreact'] = { 'eslint_d' }

--[[ DAP
DOCS:
Instalar `node-debug2-adapter`. Pode ser instalado com Mason.

--]]
local dap = require("dap")

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

-- Configuração para TypeScript (usa o mesmo adapter)
dap.configurations.typescript = dap.configurations.javascript
