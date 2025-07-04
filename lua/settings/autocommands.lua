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
vim.api.nvim_create_autocmd({"WinEnter", "InsertLeave"}, {
  desc = "Highlight trailing spaces",
  group = vim.api.nvim_create_augroup("highlight-trail", { clear = true }),
  callback = function()
    vim.schedule(function()
      local is_floating_window = vim.api.nvim_win_get_config(0).relative ~= ''
      if not is_floating_window and not vim.w.trailing_whitespace_match then
        vim.w.trailing_whitespace_match = vim.fn.matchadd("Substitute", "\\s\\+$")
      end
    end)
  end,
})
vim.api.nvim_create_autocmd({"InsertEnter"}, {
  desc = "Remove highlight trailing spaces",
  group = vim.api.nvim_create_augroup("remove-highlight-trail", { clear = true }),
  callback = function()
    if vim.w.trailing_whitespace_match then
      vim.fn.matchdelete(vim.w.trailing_whitespace_match)
      vim.w.trailing_whitespace_match = nil
    end
  end,
})

-- Notifica alteração
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  desc = "Notifica arquivo alterado",
  group = vim.api.nvim_create_augroup("notifica-arquivo-alterado", { clear = true }),
  callback = function()
    vim.notify("Arquivo modificado. Recarregando.", vim.log.levels.INFO)
    local lib_exists, gitsigns = pcall(require, "gitsigns")
    if lib_exists then
      gitsigns.refresh()
    end
  end,
})
