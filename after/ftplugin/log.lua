-- Recarrega logs automaticamente
vim.opt_local.autoread = true

local fname = vim.fn.expand("%:p")
local id = vim.api.nvim_create_augroup("autoread-" .. fname, { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained','BufEnter','CursorHold' }, {
  desc = 'Recarrega log automaticamente',
  group = id,
  buffer = vim.api.nvim_get_current_buf(),
  callback = function()
    if vim.fn.mode() == 'n' then
      -- Checa só o arquivo atual
      vim.cmd('checktime ' .. fname)
    end
  end,
})
