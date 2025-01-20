--[[
DOCS:
É possível definir linters em outros plugins, como `after/ftplugin`.
Por exemplo, em `ftplugin/markdown.lua` poderíamos ter
  local lint = require('lint')
  lint.linters_by_ft['markdown'] = { 'markdownlint' }

--]]
return {
  { 'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')
      -- NOTE:
      -- If no linters defined here, set it to emtpy:
      -- lint.linters_by_ft = {}
      lint.linters_by_ft = {
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
        -- dockerfile = { "hadolint" },
        -- yaml = { "yamllint" },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
