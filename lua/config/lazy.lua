--  DOCS:
--  https://lazy.folke.io/
--  https://github.com/folke/lazy.nvim
--  `:help lazy.nvim.txt`

-- Instala `lazy.nvim`, se necessário
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  -- Se algum plugin precisar de luarocks, considerar instalar esse pacote e habilitar rocks
  -- Rodar :checkhealth lazy
  rocks = {
    enabled = false,
  },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    -- get a notification when new updates are found
    notify = true,
    -- check daily
    frequency = 3600*24,
    -- check for pinned packages that can't be updated
    check_pinned = true,
  },
  -- Desabilita detecção de alterações na configuração
  change_detection = {
    enabled = false,
    notify = false,
  },
})
