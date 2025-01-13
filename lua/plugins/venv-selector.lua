-- Seletor de ambiente virtual Python
-- DOCS:
-- Executar `:VenvSelect` para selecionar ambiente
return {
  'linux-cultist/venv-selector.nvim',
  branch = "regexp",
  ft = "python",
  lazy = true,
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
    'mfussenegger/nvim-dap-python',
  },
  opts = {
    notify_user_on_venv_activation = true,
    debug = false,
  },
}
