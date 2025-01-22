-- DOCS:
-- Ver `:help :DiffOrig`
local M = {}

function M.diff_orig ()
  -- Lê arquivo atual
  local fname = vim.fn.expand("%:p")
  local content = vim.fn.readfile(fname)

  -- Informações do arquivo atual
  local winID = vim.api.nvim_get_current_win()
  local bufID = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_get_option_value('filetype', { buf = bufID })

  -- Cria scratch-buffer e abre em janela à esquerda
  local newbufID = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(newbufID, true, { split = 'left', win = winID })

  -- Coloca conteúdo do arquivo no scratch-buffer
  vim.api.nvim_set_option_value('filetype', ft, { buf = newbufID })
  vim.api.nvim_put(content, "", false, false)

  -- Inicia modo diff no scratch-buffer
  vim.cmd.diffthis()

  -- Volta à janela inicial e coloca em modo diff
  vim.api.nvim_set_current_win(winID)
  vim.cmd.diffthis()
end

return M
