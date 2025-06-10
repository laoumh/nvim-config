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

-- `:H` abre `help` em nova aba
vim.api.nvim_create_user_command('H', function(opts)
  vim.cmd('tab keepjumps help ' .. opts.args)
end, { nargs = '*', complete = 'help' })

-- Realça espaço em branco à direita, mas não quando em modo inserção
-- Ver `:help highlight-groups` para mais opções de cores
vim.api.nvim_create_autocmd({"BufEnter", "InsertLeave"}, {
  desc = "Highlight trailing spaces",
  group = vim.api.nvim_create_augroup("highlight-trail", { clear = true }),
  callback = function()
    vim.schedule(function()
      if not vim.g.trailing_whitespace_match then
        vim.g.trailing_whitespace_match = vim.fn.matchadd("Substitute", "\\s\\+$")
      end
    end)
  end,
})
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  desc = "Remove highlight trailing spaces",
  group = vim.api.nvim_create_augroup("remove-highlight-trail", { clear = true }),
  callback = function()
    vim.fn.matchdelete(vim.g.trailing_whitespace_match)
    vim.g.trailing_whitespace_match = nil
  end,
})
