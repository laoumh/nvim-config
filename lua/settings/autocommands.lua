-- [[ Autocommands ]]
-- DOCS: `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Sintaxe de arquivos de configuração SSH
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*/.ssh/config.*',
  command = 'setfiletype sshconfig',
})

-- Corretor ortográfico
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Habilita corretor ortográfico em arquivos markdown',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us,pt_br'
  end,
})

-- `:H` abre `help` em nova aba
vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('tab keepjumps help ' .. opts.args)
end, { nargs = '*', complete = 'help' })

