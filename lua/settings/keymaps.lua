-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[Ações]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Fecha NeoVim
vim.keymap.set('n', '<C-Q>', '<cmd>qall<CR>', { desc = 'Fecha NeoVim' })
-- Abre lista quickfix
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Mostra ou esconde diagnósticos
vim.keymap.set('n', '<leader>D', function ()
  -- bufnr = 0 --> somente buffer atual
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle Diagnostics' })

--[[Atalhos de janela e abas]]
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Fecha a janela atual' })
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { desc = 'Abre nova aba' })
vim.keymap.set('n', '<C-w>c', '<cmd>tabclose<CR>', { desc = 'Fecha aba atual' })

