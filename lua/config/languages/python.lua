--[[ LSP
DOCS:
  - https://github.com/python-lsp/python-lsp-server
  - https://microsoft.github.io/pyright/#/configuration

--]]
require('lspconfig').pyright.setup({
  capabilities = require('utils.extend-capabilities'),
})

--[[ Linter
 WARN:
`pylint` tem que estar instalado
no ambiente virtual de cada projeto

--]]
require('lint').linters_by_ft['python'] = { 'pylint' }

--[[ DAP
DOCS:
Instalar `debugpy`. Pode ser instalado com Mason ou em
ambiente virtual.

--]]
local dap = require("dap")
require("dap-python").setup(nil, {
  console = "integratedTerminal"
})

-- Adiciona opções à configuração padrão do nvim-dap-python
for _, pyconfig in ipairs(dap.configurations.python) do
  pyconfig["justMyCode"] = true
  if pyconfig["request"] == "attach" then
    pyconfig["redirectOutput"] = true
  end
end
