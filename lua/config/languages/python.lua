--[[ LSP
DOCS:
Instalar python-lsp-server:
  - `:MasonInstall python-lsp-server`
  - Ou usando pip
  - Ver https://github.com/python-lsp/python-lsp-server

--]]
require('lspconfig').pylsp.setup({
  capabilities = require('utils.extend-capabilities'),
})

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
