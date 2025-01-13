--[[
DOCS:
`:Mason` abre janela do plugin
`g?` nessa janela mostra opções
`:MasonInstall <tool>` instala a ferramenta pela linha de comando

NOTE:
Possíveis plugins úteis:
  'williamboman/mason-lspconfig.nvim'
  'WhoIsSethDaniel/mason-tool-installer.nvim'
  'jay-babu/mason-nvim-dap.nvim'
  'jay-babu/mason-null-ls.nvim'
]]
return {
  { 'williamboman/mason.nvim', opts = {} },
}
